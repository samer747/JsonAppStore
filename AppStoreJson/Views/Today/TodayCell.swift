//
//  TodayCell.swift
//  AppStoreJson
//
//  Created by samer on 7/20/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class TodayCell: TodayBaseCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    var topConstrains : NSLayoutConstraint?
    
    let categoryLabel : UILabel = {
        let l = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
        l.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return l
    }()
    
    
    let titleLabel : UILabel = {
        let l = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return l
    }()
    let descriptionLabel : UILabel = {
        let l = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
        return l
    }()
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "garden")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let containerView = UIView()
        containerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        
        let stackView = CustomStackView(arrangedSubviews: [categoryLabel,titleLabel,containerView,descriptionLabel], spacing: 8, axis: .vertical, dis: .fill)
        addSubview(stackView)
        stackView.anchorBySize(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstrains = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstrains?.isActive = true
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
