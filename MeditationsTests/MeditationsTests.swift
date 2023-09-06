//
//  MeditationsTests.swift
//  MeditationsTests
//
//  Created by Tornike on 06/09/2023.
//

import XCTest
import ComposableArchitecture
@testable import Meditations

@MainActor
final class MeditationsTests: XCTestCase {
  func testFetchingMeditations() async {
    let store = TestStore(initialState: MeditationListFeature.State()) {
      MeditationListFeature()
    } withDependencies: {
      // If we would have real networking
      // We would set here .testValue
      // Which will get mocked networking layer for testing
      $0.appNetworking = .liveValue
    }
  }
}
