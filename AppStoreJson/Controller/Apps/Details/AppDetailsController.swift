//
//  File.swift
//  AppStoreJson
//
//  Created by samer on 7/18/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppDetailsController: BaseListController , UICollectionViewDelegateFlowLayout {
    
    //MARK: Constructor
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Variables
    fileprivate let appId : String
    let cellDId = "sd"
    let cellPId = "ssd"
    let cellRid = "sdads"
    var result : Result?
    var reviews : Reviews?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailsCell.self, forCellWithReuseIdentifier: cellDId)
        collectionView.register(AppPreviewCell.self, forCellWithReuseIdentifier: cellPId)
        collectionView.register(AppReviewsCell.self, forCellWithReuseIdentifier: cellRid)
        
        navigationItem.largeTitleDisplayMode = .never
        collectionView.showsVerticalScrollIndicator = false
        
        fetchData()
    }
    
    //MARK: Methods
    fileprivate func fetchData(){
        
        let stringUrl = "https://itunes.apple.com/lookup?id=\(appId )"
        Services.shared.fetchGenericJSONData(Url: stringUrl) { (result: SearchResult?, err) in
            if let err = err {
                print("Error in fetching details : ",err)
                return
            }
            self.result = result?.results.first
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId )/sortby=mostrecent/json?l=en&cc=us"
        Services.shared.fetchGenericJSONData(Url: reviewsUrl) { (result: Reviews?, err) in
            if let err = err {
                print("Error in fetching details : ",err)
                return
            }
            self.reviews = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: ---------------- Cells setup ---------------
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellDId, for: indexPath) as! AppDetailsCell
            cell.result = self.result
            return cell
        }
        else if indexPath.item == 1{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellPId, for: indexPath) as! AppPreviewCell
            cell2.previewScreensController.result = self.result
            return cell2
        }
        else{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: cellRid, for: indexPath) as! AppReviewsCell
            cell3.appReviewController.review = self.reviews
            return cell3
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let dummyCell = AppDetailsCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
            dummyCell.result = self.result
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 200))
            
            let bestHeight = min(500,estimatedSize.height)
            
            return .init(width: view.frame.width, height: bestHeight)
        }
        else if indexPath.item == 1{
            return .init(width: view.frame.width, height: 400)
        }
        else{
            return .init(width: view.frame.width, height: 270)
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}
