//
//  PriceViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit

class PriceViewController: UIViewController, UITableViewDataSource {

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var items: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.array(forKey: "items") as? [[String: String]] ?? []
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row]["title"] ?? "") by \(items[indexPath.row]["author"] ?? ""), Progress: \(items[indexPath.row]["progress"] ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showBookAlert(title: "Edit Book", message: nil, addActionTitle: "Save") { [weak self] (title, author, progress) in
            guard let self = self else { return }
            self.items[indexPath.row]["title"] = title
            self.items[indexPath.row]["author"] = author
            self.items[indexPath.row]["progress"] = progress

            self.tableView.reloadData()
            UserDefaults.standard.setValue(self.items, forKey: "items")
        }
    }

    @objc func didTapAdd() {
        showBookAlert(title: "New Book", message: "Add a new book", addActionTitle: "Add") { [weak self] (title, author, progress) in
            guard let self = self else { return }

            let newBook = ["title": title, "author": author, "progress": progress]
            self.items.append(newBook)
            self.tableView.reloadData()
            UserDefaults.standard.setValue(self.items, forKey: "items")
        }
    }

    func showBookAlert(title: String, message: String?, addActionTitle: String, completion: @escaping (String, String, String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Enter book name"
        }

        alert.addTextField { textField1 in
            textField1.placeholder = "Enter author"
        }

        alert.addTextField { textField2 in
            textField2.placeholder = "Enter progress"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: addActionTitle, style: .default, handler: { _ in
            if let titleTextField = alert.textFields?[0].text,
               let authorTextField = alert.textFields?[1].text,
               let progressTextField = alert.textFields?[2].text {
                completion(titleTextField, authorTextField, progressTextField)
            }
        }))

        present(alert, animated: true)
    }
   
    func deleteBook(at indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
        UserDefaults.standard.setValue(items, forKey: "items")
    }

    }

extension PriceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteAlert(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (_, indexPath) in
            self?.showDeleteAlert(at: indexPath)
        }

        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] (_, indexPath) in
            self?.showBookAlert(title: "Edit Book", message: nil, addActionTitle: "Save") { (title, author, progress) in
                self?.items[indexPath.row]["title"] = title
                self?.items[indexPath.row]["author"] = author
                self?.items[indexPath.row]["progress"] = progress

                self?.tableView.reloadData()
                UserDefaults.standard.setValue(self?.items, forKey: "items")
            }
        }

        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .blue

        return [deleteAction, editAction]
    }

    
    func showDeleteAlert(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Book", message: "Are you sure you want to delete this book?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteBook(at: indexPath)
        }))

        present(alert, animated: true)
    }
}
