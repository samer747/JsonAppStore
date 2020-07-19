//
//  File.swift
//  AppStoreJson
//
//  Created by samer on 7/18/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppDetailsController: BaseListController , UICollectionViewDelegateFlowLayout {
    
    var appId : String! {
        didSet{
            let stringUrl = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
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
        }
    }
    
    let cellDId = "sd"
    let cellPId = "ssd"
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailsCell.self, forCellWithReuseIdentifier: cellDId)
        collectionView.register(AppPreviewCell.self, forCellWithReuseIdentifier: cellPId)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellDId, for: indexPath) as! AppDetailsCell
            cell.result = self.result
            return cell
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellPId, for: indexPath) as! AppPreviewCell
            cell2.previewScreensController.result = self.result
            return cell2
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
        }else{
            return .init(width: view.frame.width, height: 400)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}
