//
//  App+Dependencies.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import Foundation
import Dependencies

extension DependencyValues {
  var appNetworking: FakeNetworking {
    get { self[FakeNetworking.self] }
    set { self[FakeNetworking.self] = newValue }
  }

  var locationService: LocationService {
    get { self[LocationService.self] }
    set { self[LocationService.self] = newValue }
  }
}

extension FakeNetworking: DependencyKey {
  public static var liveValue: FakeNetworking {
    return FakeNetworking()
  }
}

extension LocationService: DependencyKey {
  public static var liveValue: LocationService {
    return LocationService()
  }
}
