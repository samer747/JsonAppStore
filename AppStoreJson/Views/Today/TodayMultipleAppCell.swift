//
//  TodayMultipleAppCell.swift
//  AppStoreJson
//
//  Created by samer on 7/21/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: TodayBaseCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
            
            multipleAppController.apps = todayItem.apps
            multipleAppController.collectionView.reloadData()
        }
    }
    
    let multipleAppController = TodayMultipleAppController(mode: .small)
    
    
    let categoryLabel : UILabel = {
        let l = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
        l.numberOfLines = 1
        return l
    }()
    
    
    let titleLabel : UILabel = {
        let l = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32))
        l.numberOfLines = 2
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        let stack = CustomStackView(arrangedSubviews: [categoryLabel,titleLabel,multipleAppController.view], spacing: 12, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
