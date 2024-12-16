//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var name = UITextField()
    var password = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UserModel.shared.loadUser()
        setupUI()
    }
    private func saveCurrentUser() {
            UserModel.shared.currentUser = User(name: name.text ?? "", password: password.text ?? "")
        }
    func setupUI(){
        let label = UILabel()
        label.text = "Login"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.frame = CGRect(x: 150, y: 280, width: 300, height: 50)
        view.addSubview(label)
        let label1 = UILabel()
        label1.text = "Write the username and password!"
        label1.textColor = .gray
        label1.font = .italicSystemFont(ofSize: 14)
        label1.numberOfLines = 1
        label1.frame = CGRect(x: 76, y: 310, width: 500, height: 50)
        view.addSubview(label1)
       
       
        name.placeholder = "Username"
        name.textColor = .black
        name.borderStyle = .roundedRect
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            name.heightAnchor.constraint(equalToConstant: 40),
            name.widthAnchor.constraint(equalToConstant: 300)
            ])
        password.placeholder = "Password"
        password.textColor = .black
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 40),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 45),
            password.heightAnchor.constraint(equalToConstant: 40),
            password.widthAnchor.constraint(equalToConstant: 300)
            ])
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 130),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc private func loginButtonTapped() {
           guard let enteredName = name.text, let enteredPassword = password.text else {
               showAlert(message: "Please enter both name and password.")
               return
           }

           print("Entered Name: \(enteredName), Entered Password: \(enteredPassword)")

           if let currentUser = UserModel.shared.currentUser {
               print("Stored User: \(currentUser)")
               if currentUser.name == enteredName && currentUser.password == enteredPassword {
                   print("User logged in successfully")
                   let vc2 = TabBarViewController()
                   vc2.modalPresentationStyle = .fullScreen
                   vc2.modalTransitionStyle = .crossDissolve
                   present(vc2, animated: true, completion: nil)
               }else {
                   showAlert(message: "Incorrect credentials. Please check your name and password.")
               }
           } else {
               showAlert(message: "User not found. Please sign up first.")
           }
       }

    func resetLoginFields() {
          name.text = ""
          password.text = ""
      }
      


    private func showAlert(message: String) {
          let alert = UIAlertController(title: "Incorrect", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
}
