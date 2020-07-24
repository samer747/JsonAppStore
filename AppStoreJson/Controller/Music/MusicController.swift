//
//  MusicController.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class MusicController: BaseListController,UICollectionViewDelegateFlowLayout {
    //MARK: ----------- Variables --------------
    let cellId = "sad55asd15"
    let footerId = "dsadsadsa"
    
    fileprivate let searchTerm = "taylor"
    
    var searchResult = [Result]()
    
    var isPaginat = false
    var finnishPaginat = false
    //MARK: ----------- ViewDidLoad --------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MusicCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: footerId)
        
        
        fetchData()
    }
    
    //MARK: ----------- Methods --------------
    fileprivate func fetchData()
    {
        let stringUrl = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=5"
        
        Services.shared.fetchGenericJSONData(Url: stringUrl) { (searchResult: SearchResult?, err) in
            if let err = err {
                //Faild :
                print("Error in fetching Music Data: ",err)
                return
            }
            //Success :
            self.searchResult = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: ----------- SetupCellsAndFooter --------------
    // Cells :
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = finnishPaginat ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResult.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicCell
        cell.searchResult = self.searchResult[indexPath.item]
        
        //Pagintion
        if indexPath.item == searchResult.count - 1 && !isPaginat && !finnishPaginat{
            let stringUrl = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(searchResult.count)&limit=5"
            isPaginat = true
            Services.shared.fetchGenericJSONData(Url: stringUrl) { (searchResult: SearchResult?, err) in
                if let err = err {
                    //Faild :
                    print("Error in fetching Music Data: ",err)
                    return
                }
                if searchResult?.results.count == 0{
                    self.finnishPaginat = true //34an myfdl4 y3ml paginate w asln el results kolha loaded
                }
                sleep(1)// byw2f el proccessing for int seconds
                //Success :
                self.searchResult += searchResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            isPaginat = false //34an my3ml4 el method de kza mara w hwa asln 48al feha
        }
        
        return cell
    }
    
    // Footer :
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
}
