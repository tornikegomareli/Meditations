//
//  FakeNetworking.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import Foundation
import Dependencies

struct FakeNetworking {
  func fetchAudioCollections() throws -> [AudioCollection] {
    if let path = Bundle.main.path(forResource: "meditations", ofType: "json"),
       let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
      let decoder = JSONDecoder()
      return try decoder.decode([AudioCollection].self, from: jsonData)
    } else {
      throw NSError(domain: "FileNotFound", code: 404, userInfo: nil)
    }
  }
}
