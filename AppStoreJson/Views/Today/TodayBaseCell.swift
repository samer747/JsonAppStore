//
//  TodayBaseCell.swift
//  AppStoreJson
//
//  Created by samer on 7/21/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class TodayBaseCell: UICollectionViewCell {
    var todayItem : TodayItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Shadows
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shouldRasterize = true //to improve the fps rate and preformance while showing the shadows
    }
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{ //kda hwa dayssss 3allll cell
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = .init(scaleX: 0.9, y: 0.9)
                    self.layer.shadowOpacity = 0
                })
                
            }else{ // kda msh metdas 3liha
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = .identity
                    self.layer.shadowOpacity = 0.4
                })
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
