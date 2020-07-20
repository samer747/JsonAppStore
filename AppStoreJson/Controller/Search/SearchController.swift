//
//  SearchController.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import SDWebImage

class SearchController: BaseListController, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    //MARK: ----------------- Variables ---------------------
    let cellId = "CellId"
    fileprivate var appsResults = [Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    var timer : Timer?
    let lable : UILabel = {
        let l = UILabel()
        l.text = "Please Enter Search Term"
        l.font = UIFont.boldSystemFont(ofSize: 25)
        l.textColor = UIColor(white: 0.5, alpha: 0.5)
        l.textAlignment = .center
        return l
    }()
    //MARK: ----------------- ViewDidLoad ---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.backgroundColor = .white
        
        setupSearchBar()
        setupLable()
    }
    //MARK: ----------------- Methods ---------------------
    //SearchBar
    fileprivate func setupSearchBar()
    {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate() // da 34an lw ktbna bsor3a my7fz4 w lma el time y5ls yfire kolo
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { (_) in
            Services.shared.fetchSearchApps(searchTerm: searchText) { (res, err) in
                if let err = err{
                    print("Print Error fetching Json app: ",err)
                }
                self.appsResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
    }
    //MARK: ----------------- Cell Setup ---------------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lable.isHidden = appsResults.count != 0
        return appsResults.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        //Results to cell
        cell.appResult = appsResults[indexPath.item]
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = String(self.appsResults[indexPath.item].trackId)
        
        let appDetailsController = AppDetailsController(appId: appId)
        navigationController?.pushViewController(appDetailsController, animated: true)
    }
    //MARK: ----------------- Lable Setup ---------------------
    fileprivate func setupLable()
    {
        collectionView.addSubview(lable)
        lable.fillSuperview(padding: .init(top: 200, left: 50, bottom: 0, right: 50))
    }
}
