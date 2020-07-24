//
//  BackEnabledNavController.swift
//  AppStoreJson
//
//  Created by samer on 7/21/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class BackEnabledNavController: UINavigationController , UIGestureRecognizerDelegate {
    //MARK: ------------------- ViewDidLoad ----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        self.navigationBar.isHidden = true
    }
    
    //MARK: ------------------- ViewSetups ----------------------
    override var prefersStatusBarHidden: Bool{ //hideTheStatusBar
        true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self //can dismiss the view by swiping from the right side
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1 //fire the gesture or no
    }

}
