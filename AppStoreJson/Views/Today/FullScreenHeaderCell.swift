//
//  FullScreenHeaderCellTableViewCell.swift
//  AppStoreJson
//
//  Created by samer on 7/20/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
class FullScreenHeaderCell: UITableViewCell {
    
    
    var todayCell = TodayCell()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
