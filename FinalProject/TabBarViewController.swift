//
//  TabBarViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit
class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        view.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .black
    }
    
    private func setupTabs(){
            let home = self.createNav(with: "Book", and: UIImage(systemName: "list.bullet.circle"), vc: BookViewController())
            let list = self.createNav(with: "List", and: UIImage(systemName: "list.bullet"), vc: PriceViewController()) 
            let history = self.createNav(with: "Location", and: UIImage(systemName: "location"), vc: MapViewController())
            let workout = self.createNav(with: "Audiobooks", and: UIImage(systemName: "headphones"), vc: MusicViewController())
            let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.circle"), vc: SettingsViewController())
        self.setViewControllers([home,list,history,workout,profile], animated: true)
        }
  
   
    
    private func createNav(with title: String, and image:UIImage?, vc:UIViewController)-> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    func changeTabBarBackgroundColor(_ color: UIColor) {
        if let tabBarControllers = tabBarController?.viewControllers {
            for viewController in tabBarControllers {
                if let navController = viewController as? UINavigationController {
                    // If the view controller is a navigation controller
                    navController.view.backgroundColor = color
                } else {
                    // If the view controller is not a navigation controller
                    viewController.view.backgroundColor = color
                }
            }
        }
    }
    
}

