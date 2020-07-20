//
//  CommentReviewCell.swift
//  AppStoreJson
//
//  Created by samer on 7/19/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class CommentReviewCell: UICollectionViewCell {
    
    var entry: Entry?{
        didSet{
            authorLabel.text = entry?.author.name.label
            bodyLabel.text = entry?.content.label
            titleLabel.text = entry?.title.label
            
            for (index, view) in starsStackView.arrangedSubviews.enumerated() {
                if let ratingInt = Int(entry!.rating.label) {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
        }
    }
    
    let titleLabel : UILabel = {
       let l = UILabel()
        l.text = "Auto Play"
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    let authorLabel : UILabel = {
       let l = UILabel()
        l.text = "SamerCore2"
        l.textColor = UIColor(white: 0.4, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    let bodyLabel : UILabel = {
       let l = UILabel()
        l.text = "Review body\nReview body\nReview body\nReview body\nReview body\nReview body"
        l.textColor = UIColor(white: 0, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 16)
        l.numberOfLines = 6
        return l
    }()
    
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        layer.masksToBounds = true
        layer.cornerRadius = 15
        
        
        setupStacks()
        
    }
    fileprivate func setupStacks(){
        let uperStack = CustomStackView(arrangedSubviews: [titleLabel,authorLabel], spacing: 5, axis: .horizontal, dis: .fill)
        let allstack = CustomStackView(arrangedSubviews: [uperStack,starsStackView,bodyLabel], spacing: 5, axis: .vertical, dis: .fill)
        addSubview(allstack)
        allstack.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor , padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
