//
//  SignupController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import Foundation
import UIKit

class SingUpViewController: UIViewController,UITextFieldDelegate {

    var name = UITextField()
    var password = UITextField()
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI(){
       
        imageView.image = UIImage(named: "image 2.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    NSLayoutConstraint.activate([
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    imageView.heightAnchor.constraint(equalToConstant: 250),
    
    ])
        let label = UILabel()
        label.text = "Registration"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.frame = CGRect(x: 140, y: 350, width: 150, height: 50)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
       
        name.placeholder = "Full name"
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
        let number = UITextField()
        number.placeholder = "Phone number"
        number.textColor = .black
        number.borderStyle = .roundedRect
        number.keyboardType = .numberPad
        number.delegate = self
        number.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(number)
        NSLayoutConstraint.activate([
            number.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 20),
            number.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 45),
            number.heightAnchor.constraint(equalToConstant: 40),
            number.widthAnchor.constraint(equalToConstant: 300)
            ])
       
        password.placeholder = "Password"
        password.textColor = .black
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: number.bottomAnchor,constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 45),
            password.heightAnchor.constraint(equalToConstant: 40),
            password.widthAnchor.constraint(equalToConstant: 300)
            ])
        let password1 = UITextField()
        password1.placeholder = "Reset Password"
        password1.textColor = .black
        password1.borderStyle = .roundedRect
        password1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password1)
        NSLayoutConstraint.activate([
            password1.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            password1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 45),
            password1.heightAnchor.constraint(equalToConstant: 40),
            password1.widthAnchor.constraint(equalToConstant: 300)
            ])
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Sign up", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: password1.bottomAnchor,constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 130),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        animateImageView()
    }
    func animateImageView() {
        UIView.animate(withDuration: 2.0, animations: {
            self.imageView.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            self.imageView.backgroundColor = .white
        }) { _ in
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
    @objc private func loginButtonTapped() {
        guard let enteredName = name.text, let enteredPassword = password.text else {
                    showAlert(message: "Please enter both name and password.")
                    return
                }
        let newUser = User(name: enteredName, password: enteredPassword)
        UserModel.shared.currentUser = newUser
        print("User signed up successfully: \(UserModel.shared.currentUser)")
        navigationController?.popViewController(animated: true)

        
        }
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

}
