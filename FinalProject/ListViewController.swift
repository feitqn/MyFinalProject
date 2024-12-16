//
//  ListViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BookDetailDelegate {
  

   var selectedBooks: [AudiobookModel] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
            tableView.backgroundColor = .systemGray6
            view.addSubview(tableView)

            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            ])

            tableView.delegate = self
            tableView.dataSource = self
        }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return selectedBooks.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                  let selectedBook = selectedBooks[indexPath.row]
                  cell.textLabel?.text = selectedBook.title
                  cell.detailTextLabel?.text = selectedBook.authors?.joined(separator: ", ")
                  return cell
       }


    func didSelectBook(_ audiobook: AudiobookModel) {
        print("Selected Book: \(audiobook.title)")
        selectedBooks.append(audiobook)
        print("Selected Books: \(selectedBooks)")
        tableView.reloadData() 
    }

}
