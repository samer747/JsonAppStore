//
//  PreviewScreensController.swift
//  AppStoreJson
//
//  Created by samer on 7/19/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class PreviewScreensController: HSnappingController , UICollectionViewDelegateFlowLayout {
    
    
    let cellId = "dasdsadas"
    var result : Result?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        collectionView.showsHorizontalScrollIndicator = false
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenCell
        let Url = URL(string: result?.screenshotUrls[indexPath.item] ?? "")
        cell.imageView.sd_setImage(with: Url)
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.screenshotUrls.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: view.frame.height)
    }
}

