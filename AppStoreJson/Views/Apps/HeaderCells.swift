//
//  CollectionViewCell.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class HeaderCells: UICollectionViewCell {
    
    let companyLable : UILabel = {
        let l = UILabel()
        l.text = "FaceBook"
        l.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: UIFont.Weight.init(14))
        l.heightAnchor.constraint(equalToConstant: 13).isActive = true
        l.numberOfLines = 1
        return l
    }()
    let titleLable : UILabel = {
        let l = UILabel()
        l.text = "Keep up with friends is faster than ever"
        l.font = UIFont.systemFont(ofSize: 24)
        l.heightAnchor.constraint(equalToConstant: 80).isActive = true
        l.numberOfLines = 2
        return l
    }()
    let imageView : UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .red
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill

        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = CustomStackView(arrangedSubviews: [companyLable,titleLable,imageView], spacing: 0, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.fillSuperview()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
