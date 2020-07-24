//
//  MultipleAppCell.swift
//  AppStoreJson
//
//  Created by samer on 7/21/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResults! {
        didSet{
            nameLable.text = app.name
            companyLable.text = app.artistName
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let imageView : UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.backgroundColor = .purple
        image.contentMode = .scaleAspectFill
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return image
    }()
    let nameLable = UILabel(text: "AppName", font: UIFont.systemFont(ofSize: 20), numberOfLines: 1)
    let companyLable = UILabel(text: "company", font: UIFont.systemFont(ofSize: 13), numberOfLines: 1)
    
    
    let getButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("GET", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.backgroundColor = UIColor(white: 0.6, alpha: 0.1)
        b.layer.cornerRadius = 15
        b.setTitleColor(UIColor.systemBlue, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: 80).isActive = true
        b.heightAnchor.constraint(equalToConstant: 30).isActive = true
        b.addTarget(self, action: #selector(handleGetButton), for: .touchUpInside)
        return b
    }()
    let seprator : UIView = {
       let v = UIView()
        v.backgroundColor = UIColor(white: 0.2, alpha: 0.1)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLable.textColor = UIColor(white: 0.5, alpha: 1)
        
        setupLayouts()
    }
    
    fileprivate func setupLayouts(){
        let lableStack = CustomStackView(arrangedSubviews: [nameLable,companyLable], spacing: 0, axis: .vertical, dis: .fill)
        
        let allStack = CustomStackView(arrangedSubviews: [imageView,lableStack,getButton], spacing: 10, axis: .horizontal, dis: .fill)
        allStack.alignment = .center
        addSubview(allStack)
        allStack.fillSuperview()
        
        addSubview(seprator)
        seprator.anchorBySize(top: nil, leading: nameLable.leadingAnchor, bottom: bottomAnchor, trailing: getButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: CGSize(width: 0, height: 0.5))
    }
    
    @objc fileprivate func handleGetButton(){
    print("Get button pressed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
