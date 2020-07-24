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
            createNavController(viewController: TodayController(), title: "TODAY", image: #imageLiteral(resourceName: "today_icon")),  // 1
            createNavController(viewController: AppsController(), title: "APPS", image: #imageLiteral(resourceName: "apps")),    // 2
            createNavController(viewController: SearchController(), title: "SEARCH", image: #imageLiteral(resourceName: "search")),// 3
            createNavController(viewController: MusicController(), title: "MUSIC", image: #imageLiteral(resourceName: "music")),  // 4
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
