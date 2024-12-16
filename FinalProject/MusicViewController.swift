//
//  MusicViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

//
//  MusicViewController.swift
//  FinalProject
//
//  Created by Admin on 21.12.2023.
//

import UIKit
import AVKit
import AVFoundation

struct SearchResult: Codable {
    let results: [AudioBook]
}

struct AudioBook: Codable, Equatable {
    let collectionName: String
    let artistName: String
    let previewUrl: String

    enum CodingKeys: String, CodingKey {
        case collectionName
        case artistName
        case previewUrl
    }
}

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    private var audiobooks: [AudioBook] = []
    private var filteredAudiobooks: [AudioBook] = []
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "Search Audiobooks"
        navigationItem.titleView = searchBar

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AudiobookCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchForAudiobooks()
    }

    func searchForAudiobooks() {
        iTunesAPIClient.shared.searchAudiobooks(term: "audiobook") { result in
            switch result {
            case .success(let audiobooks):
                self.audiobooks = audiobooks
                self.filteredAudiobooks = audiobooks
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error searching for audiobooks: \(error)")
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAudiobooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AudiobookCell", for: indexPath)

        let audiobook = filteredAudiobooks[indexPath.row]
        cell.textLabel?.text = audiobook.collectionName
        cell.detailTextLabel?.text = audiobook.artistName

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audiobook = filteredAudiobooks[indexPath.row]
        let audioDetailViewController = AudioDetailViewController()
            audioDetailViewController.audiobook = audiobook
            navigationController?.pushViewController(audioDetailViewController, animated: true)
        
    }

    func playAudio(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching audio data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                self.audioPlayer?.play()
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
        }.resume()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredAudiobooks = searchText.isEmpty ? audiobooks : audiobooks.filter { $0.collectionName.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
