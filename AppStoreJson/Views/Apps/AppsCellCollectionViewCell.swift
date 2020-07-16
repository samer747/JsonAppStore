//
//  AppsCellCollectionViewCell.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppsCell: UICollectionViewCell {
    
    
    let titleLable = UILabel(text: "Apps Section", font: UIFont.boldSystemFont(ofSize: 25), numberOfLines: 1)
    let appsHorizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLable)
        titleLable.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, leading: leadingAnchor, paddingLeft: 10, trailing: trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        addSubview(appsHorizontalController.view)
        appsHorizontalController.view.anchor(top: titleLable.bottomAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, leading: leadingAnchor, paddingLeft: 0, trailing: trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
