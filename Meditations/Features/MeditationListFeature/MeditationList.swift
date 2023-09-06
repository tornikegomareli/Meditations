//
//  MeditationList.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import SwiftUI
import ComposableArchitecture
import Dependencies
import CoreLocation
import Combine

struct MeditationListFeature: Reducer {
  struct State: Equatable {
    var isLoading: Bool = false
    var meditations: [AudioCollection] = []
    var location: CLLocation?
    var locationError: LocationError?
  }

  enum Action {
    case locationButtonTapped
    case fetchMeditations
    case meditationsResponse(meditations: [AudioCollection])
    case loadingCompleted
    case fetchLocation
    case locationErrorReceived(error: LocationError)
    case locationReceived(location: CLLocation)
  }

  var body: some ReducerOf<Self> {
    @Dependency(\.appNetworking) var networking
    @Dependency(\.locationService) var locationService
    @Dependency(\.continuousClock) var clock

    Reduce { state, action in
      switch action {
      case .fetchMeditations:
        state.isLoading = true
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          let meditations = try networking.fetchAudioCollections()
          await send(.meditationsResponse(meditations: meditations))
        }
      case .meditationsResponse(let meditationsList):
        state.isLoading = false
        state.meditations = meditationsList
        return .run { send in
          await send(.fetchLocation)
        }
      case .fetchLocation:
        state.isLoading = true
        return .run { send in
          if !CLLocationManager.locationServicesEnabled() {
            _ = locationService.requestWhenInUseAuthorization()
              .flatMap { locationService.requestLocation() }
              .sink { completion in
                if case .failure(let error) = completion {
                  Task {
                    await send(.locationErrorReceived(error: error))
                  }
                }
                Task {
                  await send(.loadingCompleted)
                }
              } receiveValue: { location in
                Task {
                  await send(.locationReceived(location: location))
                }
              }
          } else {
            await send(.loadingCompleted)
          }
        }
      case .loadingCompleted:
        state.isLoading = false
        return .none
      case .locationErrorReceived(let error):
        state.locationError = error
        return .none
      case .locationReceived(location: let location):
        state.location = location
        return .none
      case .locationButtonTapped:
        /// Fetch new Location
        /// and if latest state location does not equal
        /// current Fetched location
        return .run { send in
          await send(.fetchMeditations)
        }
      }
    }
  }
}

struct MeditationList: View {
  let store: StoreOf<MeditationListFeature>
  var gradieentTextColorFirst = Color(
    red: 203/255,
    green: 193/255,
    blue: 173/255
  )
  
  var gradieentTextColorSecond = Color(
    red: 177/255,
    green: 216/255,
    blue: 203/255
  )
  
  var gradieentTextColorThird = Color(
    red: 167/255,
    green: 224/255,
    blue: 215/255
  )

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        VStack {
          if viewStore.isLoading {
            ProgressView()
          } else {
            HStack {
              Spacer()
              Button {
                viewStore.send(.locationButtonTapped)
              } label: {
                Image(systemName: "location.circle")
                  .foregroundColor(Color.gray)
                  .font(.system(size: 50))
              }
              .padding()
            }

            HStack {
              Text("Meditations")
                .font(.largeTitle)
                .foregroundStyle(
                  .linearGradient(
                    colors: [gradieentTextColorFirst, gradieentTextColorSecond, gradieentTextColorThird],
                    startPoint: .leading,
                    endPoint: .trailing
                  )
                )
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .topLeading)
                .padding()
              Spacer()
            }

            List(viewStore.meditations, id: \.id) { audioCollection in
              CardView(title: audioCollection.title, subtitle: audioCollection.subtitle, trailingText: "\(audioCollection.id)", imageName: "ring-circle")
                .listRowBackground(Color.clear)
                .frame(alignment: .center)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
          }
        }
      }.onAppear {
        viewStore.send(.fetchMeditations)
      }
    }
  }
}

#Preview {
  MainActor.assumeIsolated {
    MeditationList(
      store: Store(
        initialState: MeditationListFeature.State()
      ) {
          MeditationListFeature()
          ._printChanges()
        }
    )
  }
}
