//
//  AudioCollection.swift
//  Meditations
//
//  Created by Tornike on 06/09/2023.
//

import Foundation
import Foundation

struct AudioCollection: Codable, Equatable, Identifiable {
    let id: Int
    let audioFiles: [AudioFile]
    let title: String
    let subtitle: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, description
        case audioFiles = "audio_files"
    }
}
