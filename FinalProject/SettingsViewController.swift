//
//  SettingsViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    let logout = UIButton()
    let swit = UISwitch()
    override func viewDidLoad() {
        swit.addTarget(self, action: #selector(switc(_:)), for: .valueChanged)
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureLogoutButton()
                
        configureUI()
        
        
        
        
    }
    func configureLogoutButton() {
           logout.frame = CGRect(x: 100, y: 650, width: 200, height: 50)
           logout.setTitle("Logout", for: .normal)
           logout.setTitleColor(.white, for: .normal)
           logout.backgroundColor = .red
           logout.layer.cornerRadius = 10
           logout.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
           self.view.addSubview(logout)
       }
    
    @objc func logoutTapped() {
          UserModel.shared.currentUser = nil
          
          // Navigate to LoginViewController
          if let loginVC = presentingViewController as? LoginViewController {
              dismiss(animated: true) {
                  loginVC.resetLoginFields() // Optional: Reset fields if needed
              }
          } else {
              // If not presented modally, navigate to LoginViewController
              let loginVC = LoginViewController()
              loginVC.modalPresentationStyle = .fullScreen
              present(loginVC, animated: true, completion: nil)
          }
      }
    func configureUI() {
        
        let label = UILabel()
        label.frame = CGRect(x: 190, y: 140, width: 200, height: 50)
        label.text = "Ratbek Bekzat"
        label.font = UIFont.systemFont(ofSize: 17)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(label)
        label.textColor = .black
        
        
        let label1 = UILabel()
        label1.frame = CGRect(x: 220, y: 160, width: 200, height: 50)
        label1.text = "online"
        label1.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(label1)
        label1.textColor = .blue
        
        
        let myimage = UIImageView()
        myimage.image = UIImage(named: "po")
        myimage.frame = CGRect(x: 30, y: 120, width: 130, height: 130)
        view.addSubview(myimage)
        
        
        
        let name = UILabel()
        name.frame = CGRect(x: 30, y: 280, width: 200, height: 50)
        name.text = "Name:"
        name.font = UIFont.systemFont(ofSize: 17)
        name.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(name)
        name.textColor = .black
        
        
        let putName = UITextField()
        putName.frame = CGRect(x: 100, y: 230, width: 150, height: 150)
        putName.text = "Bekzat"
        putName.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putName)
        
        
        let surname = UILabel()
        surname.frame = CGRect(x: 30, y: 330, width: 200, height: 50)
        surname.text = "Surname:"
        surname.font = UIFont.systemFont(ofSize: 17)
        surname.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(surname)
        name.textColor = .black
        
        
        let putName1 = UITextField()
        putName1.frame = CGRect(x: 130, y: 280, width: 150, height: 150)
        putName1.text = "Ratbek"
        putName1.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putName1)
        
        
        let age = UILabel()
        age.frame = CGRect(x: 30, y: 380, width: 100, height: 50)
        age.text = "Age:"
        age.font = UIFont.systemFont(ofSize: 17)
        age.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(age)
        name.textColor = .black
        
        
        let putage = UITextField()
        putage.frame = CGRect(x: 80, y: 330, width: 150, height: 150)
        putage.text = "21"
        putage.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putage)
        
        
        let city = UILabel()
        city.frame = CGRect(x: 30, y: 430, width: 150, height: 50)
        city.text = "City:"
        city.font = UIFont.systemFont(ofSize: 17)
        city.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(city)
        name.textColor = .black
        
        
        let putcity = UITextField()
        putcity.frame = CGRect(x: 80, y: 380, width: 150, height: 150)
        putcity.text = "Shymkent"
        putcity.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putcity)
        
        
        let number = UILabel()
        number.frame = CGRect(x: 30, y: 480, width: 150, height: 50)
        number.text = "Phone number:"
        number.font = UIFont.systemFont(ofSize: 17)
        number.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(number)
        name.textColor = .black
        
        
        let putnum = UITextField()
        putnum.frame = CGRect(x: 170, y: 430, width: 150, height: 150)
        putnum.text = "8-774-390-90-02"
        putnum.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putnum)
        
        
        let lang = UILabel()
        lang.frame = CGRect(x: 30, y: 530, width: 150, height: 50)
        lang.text = "Language:"
        lang.font = UIFont.systemFont(ofSize: 17)
        lang.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(lang)
        name.textColor = .black
        
        
        let putlang = UITextField()
        putlang.frame = CGRect(x: 130, y: 480, width: 150, height: 150)
        putlang.text = "Engilsh"
        putlang.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(putlang)
        
        
        let not = UILabel()
        not.frame = CGRect(x: 30, y: 585, width: 150, height: 50)
        not.text = "Background:"
        not.font = UIFont.systemFont(ofSize: 17)
        not.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(not)
        name.textColor = .black
       
        swit.frame = CGRect(x: 150, y: 595, width: 150, height: 50)
        switc(swit)
        view.addSubview(swit)
        }
    @objc func switc(_ sender: UISwitch){
        if sender.isOn{
            view.backgroundColor = .yellow
        }
        else{
            view.backgroundColor = .white
        }
    }


}
