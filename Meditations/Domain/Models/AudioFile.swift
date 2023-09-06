//
//  AudioFile.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import Foundation

// Define your model
struct AudioFile: Codable, Equatable {
  let id: Int
  let name: String
  let audio: URL
  let version: String
  let durationSeconds: Int

  enum CodingKeys: String, CodingKey {
    case id, name, audio, version
    case durationSeconds = "duration_seconds"
  }
}
