//
//  File.swift
//  AppStoreJson
//
//  Created by samer on 7/16/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppsHorizontalController: HSnappingController ,UICollectionViewDelegateFlowLayout {
    
    let cellID = "CellId"
    var appsGroup : AppsGroup?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    
    //MARK: ------------- CellSetup --------------
    let topBottomPadding: CGFloat = 12
    let lineSpacing:CGFloat = 10
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsGroup?.feed.results.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsRowCell
        let app = appsGroup?.feed.results[indexPath.item]
        cell.companyLable.text = app?.artistName
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        cell.nameLable.text = app?.name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ( view.frame.height - 2 * topBottomPadding - 2 * lineSpacing )/3
        return CGSize.init(width: view.frame.width - 36, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    
}
