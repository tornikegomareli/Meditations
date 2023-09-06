//
//  MeditationsApp.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct MeditationsApp: App {
    var body: some Scene {
        WindowGroup {
            MeditationList(store: Store(
              initialState: MeditationListFeature.State()
            ) {
                MeditationListFeature()
            })
        }
    }
}
