//
//  BookViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit


class BookViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
 
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search books"
        return searchBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AudiobookCell")
        return tableView
    }()

    private var audiobooks: [AudiobookModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(searchBar)
        view.addSubview(tableView)

        // Set up constraints for searchBar and tableView
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }

        searchAudiobooks(query: query)
        searchBar.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audiobooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AudiobookCell", for: indexPath)
        let audiobook = audiobooks[indexPath.row]
        cell.textLabel?.text = audiobook.title
        cell.detailTextLabel?.text = audiobook.authors?.joined(separator: ", ")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAudiobook = audiobooks[indexPath.row]
        showAudiobookDetails(for: selectedAudiobook)

    }

    private func searchAudiobooks(query: String) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)&filter=free-ebooks") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let items = json["items"] as? [[String: Any]] {
                    self.audiobooks = items.compactMap { AudiobookModel(json: $0) }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

    private func showAudiobookDetails(for audiobook: AudiobookModel) {
        let detailViewController = BookDetailViewController(audiobook: audiobook)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
