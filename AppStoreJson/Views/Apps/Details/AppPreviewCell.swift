//
//  AppPreviewCell.swift
//  AppStoreJson
//
//  Created by samer on 7/19/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppPreviewCell: UICollectionViewCell {
    let previewLable : UILabel = {
        let l = UILabel()
        l.text = "   Preview"
        l.font = UIFont.boldSystemFont(ofSize: 23)
        l.heightAnchor.constraint(equalToConstant: 22).isActive = true
        return l
    }()
    
    let previewScreensController = PreviewScreensController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = CustomStackView(arrangedSubviews: [previewLable,previewScreensController.view], spacing: 10, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
