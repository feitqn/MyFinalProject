//
//  ViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit


class MainPageController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Books"
        return searchBar
    }()

    private var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "eBooks App"

        setupSearchBar()
        setupTableView()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
    }


    private func fetchBooks(for query: String) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)&key=AIzaSyBhRP8RS0EQTh8GtAMxqRgXhKC39FFOj5E") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error fetching books: \(error.localizedDescription)")
                } else {
                    print("No data received from the server.")
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GoogleBooksResponse.self, from: data)
                self?.books = response.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }


    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.volumeInfo.title
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)

          let selectedBook = books[indexPath.row]
          showBookDetail(for: selectedBook)
      }
      private func showBookDetail(for book: Book) {
          //let bookDetailViewController = BookDetailViewController(book: book)
          //navigationController?.pushViewController(bookDetailViewController, animated: true)
      }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Perform book search based on user input
        fetchBooks(for: searchText)
    }
}

