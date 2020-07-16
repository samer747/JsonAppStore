//
//  File.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController ,UICollectionViewDelegateFlowLayout {
    
    let cellID = "CellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: cellID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.scrollDirection = .horizontal
        }
        //collectionView.isPagingEnabled = true
        
    }
    
    
    //MARK: ------------- CellSetup --------------
    let topBottomPadding: CGFloat = 12
    let lineSpacing:CGFloat = 10
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsRowCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ( view.frame.height - 2 * topBottomPadding - 2 * lineSpacing )/3
        return CGSize.init(width: view.frame.width - 36, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    
}
