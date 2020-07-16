//
//  SearchCell.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
       
    var appResult: Result! {
        didSet{
            appNameLable.text = appResult.trackName
            
            catgoryLable.text = appResult.primaryGenreName
            
            let formatted = String(format: "%.1f", appResult.averageUserRating ?? 0.0 as CVarArg)
            ratingLable.text = "Rating: \(formatted)"
            //getting the Icon
            let url = URL(string: appResult.artworkUrl60)
            imageView.sd_setImage(with: url)
            //getting the Screens
            if appResult.screenshotUrls.count == 0{
                return
            }
            else if appResult.screenshotUrls.count == 1 {
                screen1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            }
            else if appResult.screenshotUrls.count == 2 {
                screen1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
                screen2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            else{
                screen1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
                screen2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
                screen3.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    //MARK: --------- Variables ---------
    let imageView : UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .white
        i.layer.cornerRadius = 12
        i.clipsToBounds = true
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
    
    let screen1 :UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .white
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        i.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        i.layer.borderWidth = 0.5
        i.contentMode = .scaleAspectFill
        return i
    }()
    let screen2 :UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .white
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        i.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        i.layer.borderWidth = 0.5
        i.contentMode = .scaleAspectFill
        return i
    }()
    let screen3 :UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .white
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        i.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        i.layer.borderWidth = 0.5
        i.contentMode = .scaleAspectFill
        return i
    }()
   
    
    //MARK: --------- ViewDidLoad ---------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayouts()
        
    }
    
    //MARK: --------- FuncTions ---------
    fileprivate func setupLayouts()
    {
        //Lables Stack
        let lablesStack = CustomStackView(arrangedSubviews: [appNameLable,catgoryLable,ratingLable], spacing: 2, axis: .vertical, dis: .fill)
        
        //info stack
        let infoStack = CustomStackView(arrangedSubviews: [imageView,lablesStack,cellButton], spacing: 8, axis: .horizontal, dis: .fill)
        infoStack.alignment = .center
       
        //imagesStack
        let imagesStack = CustomStackView(arrangedSubviews: [screen1,screen2,screen3], spacing: 8, axis: .horizontal, dis: .fillEqually)
        
        let allStack = CustomStackView(arrangedSubviews: [infoStack,imagesStack], spacing: 10, axis: .vertical, dis: .fill)
        addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
