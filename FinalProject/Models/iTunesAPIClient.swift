//
//  iTunesAPIClient.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//


import Foundation

struct SearchResponse: Codable {
    let results: [AudioBook]

    private enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([AudioBook].self, forKey: .results)
    }
}

class iTunesAPIClient {

    static let shared = iTunesAPIClient()
    private let baseURL = "https://itunes.apple.com/search"

    private init() {}

    func searchAudiobooks(term: String, completion: @escaping (Result<[AudioBook], Error>) -> Void) {
        let url = URL(string: "\(baseURL)?term=\(term)&media=audiobook")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
