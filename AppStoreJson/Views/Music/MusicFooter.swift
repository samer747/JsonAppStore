//
//  MusicFooter.swift
//  AppStoreJson
//
//  Created by samer on 7/24/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class MusicFooter: UICollectionReusableView {
    
    let indecator = UIActivityIndicatorView(style: .large)
    let lable : UILabel = {
        let l = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
           
        indecator.startAnimating()
        
        let stack = CustomStackView(arrangedSubviews: [indecator,lable], spacing: 8, axis: .vertical, dis: .fill)
        addSubview(stack)
        stack.centerInSuperview(size: .init(width: 200, height: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
