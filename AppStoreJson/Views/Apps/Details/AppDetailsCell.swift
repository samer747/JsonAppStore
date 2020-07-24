//
//  AppDetailsCell.swift
//  AppStoreJson
//
//  Created by samer on 7/18/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppDetailsCell: UICollectionViewCell {
    
    var result : Result! {
        didSet{
            nameLable.text = result?.trackName
            companyLable.text = result?.artistName
            priceButton.setTitle(result?.formattedPrice, for: .normal)
            iconImageView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
            notesLable.text = result?.releaseNotes
            versionLable.text = result?.version
        }
    }
    
    let iconImageView : UIImageView = {
        let i = UIImageView()
        i.heightAnchor.constraint(equalToConstant: 120).isActive = true
        i.widthAnchor.constraint(equalToConstant: 120).isActive = true
        i.backgroundColor = .white
        i.clipsToBounds = true
        i.layer.cornerRadius = 18
        return i
    }()
    let nameLable : UILabel = {
       let l = UILabel()
        l.numberOfLines = 2
        l.font = UIFont.boldSystemFont(ofSize: 26)
        return l
    }()
    let companyLable : UILabel = {
       let l = UILabel()
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor(white: 0.5, alpha: 1)
        l.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return l
    }()
    let newLable : UILabel = {
       let l = UILabel()
        l.numberOfLines = 1
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = "What's New"
        l.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return l
    }()
    let versionLable : UILabel = {
       let l = UILabel()
        l.numberOfLines = 1
        l.textColor = UIColor(white: 0.4, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 16)
        l.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return l
    }()
    let notesLable : UILabel = {
       let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    let priceButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = #colorLiteral(red: 0.2181423604, green: 0.4732804894, blue: 0.9671389461, alpha: 1)
        b.setTitle("", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 14
        b.widthAnchor.constraint(equalToConstant: 80).isActive = true
        b.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStacks()
    }
    fileprivate func setupStacks(){
        let nameCompPriceStack = CustomStackView(arrangedSubviews: [nameLable,companyLable,UIView(),priceButton], spacing: 5, axis: .vertical, dis: .fill)
        nameCompPriceStack.alignment = .leading
        let imageStack = CustomStackView(arrangedSubviews: [iconImageView,nameCompPriceStack], spacing: 12, axis: .horizontal, dis: .fill)
        let allStack = CustomStackView(arrangedSubviews: [imageStack,newLable,versionLable,notesLable], spacing: 8, axis: .vertical, dis: .fill)

        addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
