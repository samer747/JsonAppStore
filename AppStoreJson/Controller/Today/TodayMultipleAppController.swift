//
//  TodayMultipleAppController.swift
//  AppStoreJson
//
//  Created by samer on 7/21/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class TodayMultipleAppController: BaseListController ,UICollectionViewDelegateFlowLayout {
    //MARK: ------------------- Variables ----------------------
    var apps = [FeedResults]()
    let cellId = "4a5d6s6a5d8s7a"
    fileprivate let spacing: CGFloat = 16
    
    //Enum
    fileprivate let mode : Mode
    enum Mode {
        case small , fullscreen
    }
    
    //MARK: ------------------- Initilizers ----------------------
    init(mode:Mode){
        
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------------------- Conponts ----------------------
    let closeButton : UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        b.tintColor = .darkGray
        b.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return b
    }()
    
    //MARK: ------------------- ViewDidLoad ----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullscreen {
            setupCloseButton()
            collectionView.isScrollEnabled = true
        }
        
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: ------------------- Methods ----------------------
    @objc func handleClose()
    {
        dismiss(animated: true, completion: nil)
        
    }
    
    fileprivate func setupCloseButton(){
        view.addSubview(closeButton)
        closeButton.anchorBySize(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    override var prefersStatusBarHidden: Bool{ return true }//hide status bar
    
    //MARK: ------------------- Cells Setup ----------------------
    
    //didSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = AppDetailsController(appId: apps[indexPath.item].id)
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    //cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.app = self.apps[indexPath.item]
        return cell
    }
    
    //numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.mode == .fullscreen {
            return apps.count
        }
        return min(4,self.apps.count)
    }
    
    //sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.mode == .fullscreen {
            return CGSize(width: view.frame.width - 30, height: 75)
        }
        let height :CGFloat = ( view.frame.height - 3 * spacing ) / 4
        return CGSize(width: view.frame.width, height: height)
    }
    
    //minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return spacing
    }
    
    //insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 15, bottom: 12, right: 15)
        }
        return .zero
    }
}
