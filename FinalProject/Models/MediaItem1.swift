//
//  MediaItem1.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import Foundation

struct AudioBook1: Codable {
    let title: String
    let author: String
    let description: String
    let artworkUrl: String
    // Add other audiobook-specific fields as needed

    private enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case author = "artistName"
        case description = "collectionCensoredName"
        case artworkUrl = "artworkUrl100"
        // Map other fields from the audiobook API response
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        description = try container.decode(String.self, forKey: .description)
        artworkUrl = try container.decode(String.self, forKey: .artworkUrl)
        // Decode other fields as needed
    }
}

