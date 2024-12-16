//
//  BookDetailViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//
import UIKit

protocol BookDetailDelegate: AnyObject {
    func didSelectBook(_ audiobook: AudiobookModel)
}

class BookDetailViewController: UIViewController, BookDetailDelegate {
    
    func didSelectBook(_ audiobook: AudiobookModel) {
        // Реализация метода (если нужно)
    }
    
    weak var delegate: BookDetailDelegate?
    private let audiobook: AudiobookModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
   
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let readButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read book", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(openPreviewLink), for: .touchUpInside)
        return button
    }()

    init(audiobook: AudiobookModel) {
        self.audiobook = audiobook
        super.init(nibName: nil, bundle: nil)
        title = "Book Detail"
        print("Audiobook Title: \(audiobook.title)")
        print("Audiobook author:\(String(describing: audiobook.authors))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        if let thumbnailURL = audiobook.thumbnailURL {
            loadImage(from: thumbnailURL)
        }
    }

    private func setupUI() {
        titleLabel.text = "Title: \(audiobook.title)"
        if let authors = audiobook.authors, !authors.isEmpty {
            let authorsString = authors.joined(separator: ", ")
            authorLabel.text = "Author: \(authorsString)"
        } else {
            authorLabel.text = "Author: N/A"
        }

        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(thumbnailImageView)
        view.addSubview(readButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        readButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            thumbnailImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),

            readButton.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
            readButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            readButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            readButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                return
            }

            if let thumbnailImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = thumbnailImage
                }
            }
        }.resume()
    }

    @objc private func openPreviewLink() {
        if let previewLink = audiobook.previewLink, UIApplication.shared.canOpenURL(previewLink) {
            UIApplication.shared.open(previewLink, options: [:], completionHandler: nil)
            self.delegate?.didSelectBook(self.audiobook)
            self.tabBarController?.selectedIndex = 1
            let navVC = tabBarController?.viewControllers![1] as! UINavigationController
            _ = navVC.topViewController as! PriceViewController
        }
    }
}
