//
//  BaseListClass.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController { // da 34an y3ml init bel UICollectionViewFlowLayout 3ltol w mygb4 el error bta3 must be initizled
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
       // collectionView.backgroundColor = .systemBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

