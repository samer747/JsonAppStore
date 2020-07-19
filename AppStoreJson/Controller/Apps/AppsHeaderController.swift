//
//  CollectionViewController.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppsHeaderController: HSnappingController , UICollectionViewDelegateFlowLayout {
    //MARK: --------- Variables ----------
    var headerDic = [HeaderGroup]() 
    //MARK: --------- ViewDidLoad ----------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        self.collectionView!.register(HeaderCells.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    //MARK: --------- Cell Setup ----------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerDic.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeaderCells
        
        
        cell.companyLable.text = headerDic[indexPath.item].name
        
        let url = URL(string: headerDic[indexPath.item].imageUrl)
        cell.imageView.sd_setImage(with: url)
        
        cell.tagLineLable.text = headerDic[indexPath.item].tagline
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: view.frame.height)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    

   

}
