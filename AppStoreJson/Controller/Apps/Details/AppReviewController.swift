//
//  AppReviewController.swift
//  AppStoreJson
//
//  Created by samer on 7/19/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppReviewController: HSnappingController , UICollectionViewDelegateFlowLayout {

    
    var review : Reviews?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        self.collectionView!.register(CommentReviewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return review?.feed.entry.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentReviewCell
        
        let entry = review?.feed.entry[indexPath.item]
        cell.entry = entry
        
        
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 32, height: 200)
    }
    

}
