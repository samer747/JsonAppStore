//
//  AppsHeader.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppsHeader: UICollectionReusableView{
    let appsHeaderController = AppsHeaderController()
    override init(frame: CGRect) {
        super.init(frame: frame )
        
        addSubview(appsHeaderController.view)
        appsHeaderController.view.fillSuperview(padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
