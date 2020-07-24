//
//  MusicCell.swift
//  AppStoreJson
//
//  Created by samer on 7/23/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    var searchResult :Result!{
            didSet{
                imageView.sd_setImage(with: URL(string: searchResult.artworkUrl100))
                nameLable.text = searchResult.trackName
                artiestLable.text = searchResult.artistName
                albumNameLable.text = searchResult.collectionName
            }
        }
    
    
    let imageView : UIImageView = {
       let i = UIImageView()
        i .backgroundColor = .black
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.widthAnchor.constraint(equalToConstant: 68).isActive = true
        i.heightAnchor.constraint(equalToConstant: 68).isActive = true
        i.layer.cornerRadius = 16
        return i
    }()
    
    let nameLable : UILabel = {
       let l = UILabel()
        l.text = "The Drum"
        l.font = UIFont.boldSystemFont(ofSize: 18)
        return l
    }()
    let artiestLable : UILabel = {
       let l = UILabel()
        l.text = "taylor swift"
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    let albumNameLable : UILabel = {
       let l = UILabel()
        l.text = "Pop Music"
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lablesStack = CustomStackView(arrangedSubviews: [nameLable,artiestLable,albumNameLable], spacing: 4, axis: .vertical, dis: .fill)
        let allStack = CustomStackView(arrangedSubviews: [imageView,lablesStack], spacing: 10, axis: .horizontal, dis: .fill)
        allStack.alignment = .center
        addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
