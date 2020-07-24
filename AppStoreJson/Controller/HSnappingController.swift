//
//  HSnappingController.swift
//  AppStoreJson
//
//  Created by samer on 7/17/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

//34an yzbot el horzontl swiping w lazm t3ml content insits b2a fe el class ely b inhirt mn da
/*
 collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
 */
class HSnappingController: UICollectionViewController {
    
    init() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast //bt7ded sor3et el scroll
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK: -------------------- mloooo4 lazma dlw2ty 5las el better snaping class a7sn -----------------------
class SnappingLayout: UICollectionViewFlowLayout {
    // snap behavior
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        // we're using a magical 48
        let itemWidth = collectionView.frame.width - 36
        
        let itemSpace = itemWidth + minimumInteritemSpacing
        var pageNumber = round(collectionView.contentOffset.x / itemSpace)
        
        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x
        if vX > 0 {
            pageNumber += 1
        } else if vX < 0 {
            pageNumber -= 1
        }
        
        let nearestPageOffset = pageNumber * itemSpace
        return CGPoint(x: nearestPageOffset,
                       y: parent.y)
    }
    
}
