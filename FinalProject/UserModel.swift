//
//  UserModel.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit

struct User {
    var name: String
    var password: String

}

class UserModel {
    static let shared = UserModel()

    var currentUser: User? {
        didSet {
            saveUser()
        }
    }

     func saveUser() {
        if let currentUser = currentUser {
            let userDict: [String: Any] = ["name": currentUser.name, "password": currentUser.password]
            UserDefaults.standard.set(userDict, forKey: "currentUser")
        } else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
        }
    }

  func loadUser() {
        if let userDict = UserDefaults.standard.dictionary(forKey: "currentUser"),
            let name = userDict["name"] as? String,
            let password = userDict["password"] as? String
      {
            currentUser = User(name: name, password: password)
        }
    }

    init() {
        loadUser()
    }
}

