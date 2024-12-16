//
//  AudiobookModel.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import Foundation

struct AudiobookModel {
    let title: String
    let authors: [String]?
    let thumbnailURL: URL?
    let previewLink: URL?

    init(title: String, authors: [String]?, thumbnailURL: URL?, previewLink: URL?) {
        self.title = title
        self.authors = authors
        self.thumbnailURL = thumbnailURL
        self.previewLink = previewLink
    }

    init?(json: [String: Any]) {
        guard let volumeInfo = json["volumeInfo"] as? [String: Any],
              let title = volumeInfo["title"] as? String else {
            return nil
        }

        self.title = title
        self.authors = volumeInfo["authors"] as? [String]
        self.thumbnailURL = {
            if let imageLinks = volumeInfo["imageLinks"] as? [String: String],
               let thumbnailURLString = imageLinks["thumbnail"],
               let thumbnailURL = URL(string: thumbnailURLString) {
                return thumbnailURL
            }
            return nil
        }()
        self.previewLink = {
            if let previewLinkString = volumeInfo["previewLink"] as? String,
               let previewLink = URL(string: previewLinkString) {
                return previewLink
            }
            return nil
        }()
    }
}

