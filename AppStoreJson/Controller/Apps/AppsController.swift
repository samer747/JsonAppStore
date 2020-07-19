


import UIKit
class AppsController: BaseListController,UICollectionViewDelegateFlowLayout {
    //MARK: ---------- variables --------------
    let cellId = "id"
    let headerId = "ID"
    var groups = [AppsGroup]()
    var headerDic = [HeaderGroup]()
    
     
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let a = UIActivityIndicatorView(style: .large)
        a.color = .systemBlue
        a.startAnimating()
        a.hidesWhenStopped = true
        return a
    }()
    
    //MARK: ---------- ViewDidLoad --------------
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshController
        
        collectionView.showsVerticalScrollIndicator = false
        
        fetchGroups()
        
    }
    
    //MARK: ---------- Methods --------------
    //MARK:  Handle Refreshing
    @objc fileprivate func handleRefresh(){
        groups.removeAll()
        headerDic.removeAll()
        collectionView.reloadData()
        fetchGroups()
    }
    fileprivate func fetchGroups(){
        let disPatchGroup = DispatchGroup()
        var group1 : AppsGroup?
        var group2 : AppsGroup?
        var group3 : AppsGroup?
        
        //Cells
        disPatchGroup.enter()
        Services.shared.fetchTopGrossing { (appsGroups, err) in
            disPatchGroup.leave()
            
            guard let appGroup = appsGroups else {return}
            group1 = appGroup
            
        }
        disPatchGroup.enter()
        Services.shared.fetchTopPaid { (appsGroups, err) in
            disPatchGroup.leave()
            
            guard let appGroup = appsGroups else {return}
            group2 = appGroup
        }
        disPatchGroup.enter()
        Services.shared.fetchTopFree { (appsGroups, err) in
            disPatchGroup.leave()
            
            guard let appGroup = appsGroups else {return}
            group3 = appGroup
            
        }
        
        //Header
        disPatchGroup.enter()
        Services.shared.fetchAppsHeaderData { (headerDic, err) in
            disPatchGroup.leave()
            if let err = err {
                ///Faild
                print("Error in fetchappsHeaderData : ",err)
                return
            }
            ///success
            if let dic = headerDic {
            self.headerDic = dic
            }
        }
        
        //de 34an yt3mlo kolhom mara wa7da bel tarteeb
        disPatchGroup.notify(queue: .main) {
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.refreshControl?.endRefreshing()
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    //MARK: ---------- Header Setups --------------
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsHeader
        header.appsHeaderController.headerDic = self.headerDic
        header.appsHeaderController.collectionView.reloadData()
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    //MARK: ---------- Cell Setups --------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsCell
        
        cell.titleLable.text = groups[indexPath.item].feed.title
        cell.appsHorizontalController.appsGroup = self.groups[indexPath.item]
        cell.appsHorizontalController.didSelectItem = { [weak self] feedResult in
            
            let controller = AppDetailsController()
            controller.appId = feedResult.id
            controller.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
