//
//  ViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoginButton()
    }

     func setupLoginButton() {
         let loginButton = UIButton(type: .system)
         loginButton.setTitle("Login", for: .normal)
         loginButton.setTitleColor(.white, for: .normal)
         loginButton.backgroundColor = .blue
         loginButton.layer.cornerRadius = 10
         loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
         view.addSubview(loginButton)
         loginButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 40),
             loginButton.widthAnchor.constraint(equalToConstant: 150),
             loginButton.heightAnchor.constraint(equalToConstant: 40)
         ])
            let signUpButton = UIButton(type: .system)
            signUpButton.setTitle("Sign Up", for: .normal)
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.backgroundColor = .blue
            signUpButton.layer.cornerRadius = 10
            signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            view.addSubview(signUpButton)
            signUpButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
                signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signUpButton.widthAnchor.constraint(equalToConstant: 150),
                signUpButton.heightAnchor.constraint(equalToConstant: 40)
            ])
             let imageView = UIImageView()
             imageView.image = UIImage(named: "image 1.png")
             imageView.translatesAutoresizingMaskIntoConstraints = false
             imageView.contentMode = .scaleAspectFit
             view.addSubview(imageView)
         NSLayoutConstraint.activate([
         imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
         imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         imageView.heightAnchor.constraint(equalToConstant: 250),
         
         ])
         let label = UILabel()
         label.text = "Welcome to app"
         label.textColor = .black
         label.font = .boldSystemFont(ofSize: 20)
         label.numberOfLines = 1
         label.frame = CGRect(x: 120, y: 120, width: 300, height: 50)
         view.addSubview(label)
        
        }
    @objc private func loginButtonTapped() {
               let secondViewController = LoginViewController()
               present(secondViewController, animated: true, completion: nil)
        }

        @objc private func signUpButtonTapped() {
            let vc = SingUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }


}
