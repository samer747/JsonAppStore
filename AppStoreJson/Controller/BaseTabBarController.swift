//
//  File.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewControllers = [
            createNavController(viewController: AppsController(), title: "APPS", image: #imageLiteral(resourceName: "apps")),
            createNavController(viewController: TodayController(), title: "TODAY", image: #imageLiteral(resourceName: "today_icon")),
            createNavController(viewController: SearchController(), title: "SEARCH", image: #imageLiteral(resourceName: "search")),
            createNavController(viewController: MusicController(), title: "MUSIC", image: #imageLiteral(resourceName: "music"))
        ]
    }
    
    
    fileprivate func createNavController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
        
    }
}
