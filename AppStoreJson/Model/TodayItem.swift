//
//  TodayItem.swift
//  AppStoreJson
//
//  Created by samer on 7/20/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    // enum
    
   let cellType: CellType
    
    let apps: [FeedResults]
    
    enum CellType: String {
        case single, multiple
    }
    
}
