//
//  ReviewsCell.swift
//  AppStoreJson
//
//  Created by samer on 7/19/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppReviewsCell: UICollectionViewCell {
    
    let reviewLable : UILabel = {
           let l = UILabel()
           l.text = "   Review & Rating"
           l.font = UIFont.boldSystemFont(ofSize: 22)
           l.heightAnchor.constraint(equalToConstant: 24).isActive = true
           return l
       }()
    
    let appReviewController = AppReviewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stack = CustomStackView(arrangedSubviews: [reviewLable,appReviewController.view], spacing: 0, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
