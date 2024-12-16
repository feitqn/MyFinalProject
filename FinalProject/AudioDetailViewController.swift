//
//  AudioDetailViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit
import AVFoundation

class AudioDetailViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
       }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "4693365.png")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var timer: Timer?
    var speechSynthesizer = AVSpeechSynthesizer()


    var audiobook: AudioBook?
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(playButton)
        view.addSubview(currentTimeLabel)
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
    
            playButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 130),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            
            currentTimeLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 40),
            currentTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
                 
        loadAndAnimateBookImage()
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        if let audiobook = audiobook {
            titleLabel.text = audiobook.collectionName
            authorLabel.text = audiobook.artistName
        }
    }

    @objc func playButtonTapped() {
        guard let audiobook = audiobook,
              let url = URL(string: audiobook.previewUrl) else {
            return
        }

        if audioPlayer == nil {
            playAudio(from: url)
            playButton.setTitle("Stop", for: .normal)
        } else {
            stopAudio()
            playButton.setTitle("Play", for: .normal)
        }
    }

    func playAudio(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTimeLabel), userInfo: nil, repeats: true)
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateCurrentTimeLabel() {
            guard let audioPlayer = audioPlayer else {
                return
            }

            let currentTimeInSeconds = Int(audioPlayer.currentTime)
            let minutes = currentTimeInSeconds / 60
            let seconds = currentTimeInSeconds % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
    
    func loadAndAnimateBookImage() {
           if let imageURL = URL(string: "bookImageURL") {
               URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                   guard let data = data, let image = UIImage(data: data) else {
                       return
                   }

                   DispatchQueue.main.async {
                       self?.imageView.image = image
                       self?.animateImageView()
                   }
               }.resume()
           }
       }

    func animateImageView() {
        UIView.animate(withDuration: 2.0, animations: {
            self.imageView.center = CGPoint(x: 200, y: 400)
            self.imageView.backgroundColor = .white
        }) { _ in
            print("You can do it!")
        }
    }
}
