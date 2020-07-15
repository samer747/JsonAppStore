//
//  SearchCell.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    //MARK: --------- Variables ---------
    let imageView : UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .red
        i.layer.cornerRadius = 8
        i.translatesAutoresizingMaskIntoConstraints = false
        i.widthAnchor.constraint(equalToConstant: 60).isActive = true
        i.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return i
    }()
    let cellButton : UIButton = {
        let b = UIButton()
        b.setTitle("Get", for: .normal)
        b.backgroundColor = UIColor(white: 0.95, alpha: 1)
        b.layer.cornerRadius = 15
        b.setTitleColor(UIColor.systemBlue, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: 80).isActive = true
        b.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return b
    }()
    let appNameLable : UILabel = {
       let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.text = "App Name"
        return l
    }()
    let catgoryLable : UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor(white: 0.5, alpha: 1)
        l.text = "Video & Photos"
        return l
    }()
    let ratingLable : UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor(white: 0.7, alpha: 1)
        l.text = "Rating: 4.5"
        return l
    }()
   
    
    //MARK: --------- ViewDidLoad ---------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupLayouts()
        
    }
    
    //MARK: --------- FuncTions ---------
    fileprivate func setupLayouts()
    {
        let image1 :UIImageView = {
           let i = UIImageView()
            i.backgroundColor = .blue
            i.layer.cornerRadius = 10
            return i
        }()
        let image2 :UIImageView = {
           let i = UIImageView()
            i.backgroundColor = .blue
            i.layer.cornerRadius = 10
            return i
        }()
        let image3 :UIImageView = {
           let i = UIImageView()
            i.backgroundColor = .blue
            i.layer.cornerRadius = 10
            return i
        }()
        
        //Lables Stack
        let lablesStack = CustomStackView(arrangedSubviews: [appNameLable,catgoryLable,ratingLable], spacing: 2, axis: .vertical, dis: .fill)
        
        //info stack
        let infoStack = CustomStackView(arrangedSubviews: [imageView,lablesStack,cellButton], spacing: 8, axis: .horizontal, dis: .fill)
        infoStack.alignment = .center
       
//        addSubview(infoStack)
//        infoStack.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, leading: leadingAnchor, paddingLeft: 10, trailing: trailingAnchor, paddingRight: 10, width: 0, height: 70)
//
        //imagesStack
        let imagesStack = CustomStackView(arrangedSubviews: [image1,image2,image3], spacing: 8, axis: .horizontal, dis: .fillEqually)
        
//        addSubview(imagesStack)
//       imagesStack.anchor(top: infoStack.bottomAnchor, paddingTop: 5, bottom: bottomAnchor, paddingBottom: 0, leading: leadingAnchor, paddingLeft: 5, trailing: trailingAnchor, paddingRight: 5, width: 0, height: 0)
        let allStack = CustomStackView(arrangedSubviews: [infoStack,imagesStack], spacing: 10, axis: .vertical, dis: .fill)
        addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
