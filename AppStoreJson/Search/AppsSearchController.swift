//
//  SearchController.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout {
    //MARK: ----------------- Variables ---------------------
    let cellId = "CellId"
    fileprivate var appsResults = [Result]()
    
    //MARK: ----------------- ViewDidLoad ---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchJsonData()
    }
    //MARK: ----------------- Methods ---------------------
    
    fileprivate func fetchJsonData()
    {
        Services.shared.fetchApps { (res, err) in
            if let err = err{
                print("Print Error fetching Json app: ",err)
            }
            self.appsResults = res
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    //MARK: ----------------- Cell Setup ---------------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsResults.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        let appResult = appsResults[indexPath.item]
        
        cell.appNameLable.text = appResult.trackName
        
        cell.catgoryLable.text = appResult.primaryGenreName
        
        let formatted = String(format: "%.1f", appResult.averageUserRating ?? 0.0 as CVarArg)
        cell.ratingLable.text = "Rating: \(formatted)"
        
        return cell
    }
}
