//
//  TodayController.swift
//  AppStoreJson
//
//  Created by samer on 7/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class TodayController: BaseListController,UICollectionViewDelegateFlowLayout , UIGestureRecognizerDelegate  {
    
    //MARK: ----------- Variables --------------
    
    // Animation Variables :-
    var startingFrame: CGRect?
    var fullScreenController : AppFullScreenController!
    var anchoredConstraints : AnchoredConstraints?
    static let cellSize: CGFloat = 500
    
    var items = [TodayItem]()
    
    let indicator : UIActivityIndicatorView = {
       let i = UIActivityIndicatorView()
        i.color = .darkGray
        i.startAnimating()
        i.hidesWhenStopped = true
        return i
    }()
     
    let bluredVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    //MARK: ----------- ViewDidLoad --------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bluredVisualEffectView)
        bluredVisualEffectView.fillSuperview()
        bluredVisualEffectView.alpha = 0
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(indicator)
        indicator.centerInSuperview()
        
        fetchFullScreenData()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9489565492, green: 0.9490664601, blue: 0.9489073157, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    //MARK: ----------------- Methods ----------------------
    
    //FetchingTheHorizontleCellsAppsData
    fileprivate func fetchFullScreenData(){
        let dispatchGroup = DispatchGroup()
        var topGrossing : AppsGroup?
        var topPaid : AppsGroup?
        
        dispatchGroup.enter()
        Services.shared.fetchTopGrossing { (appGroup, err) in
            topGrossing = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Services.shared.fetchTopPaid { (appGroup, err) in
            topPaid = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            
            self.items = [TodayItem.init(category: "THE DAILY LIST", title: topGrossing?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), description: "", backgroundColor: .white ,cellType: .multiple, apps: topGrossing?.feed.results ?? []),
                          TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white,cellType: .single, apps: []) ,
                          TodayItem.init(category: "Daily List", title: topPaid?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), description: "Bmw & Marcieds Benz : Cheak Best Cars NOW", backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,cellType: .multiple, apps: topPaid?.feed.results ?? []),
                          TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "holiday"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: #colorLiteral(red: 0.9797936082, green: 0.9509528279, blue: 0.7239444852, alpha: 1),cellType: .single, apps: []) ]
            
            self.collectionView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    //HandleTheGestureOnThe innerControllerCell
    @objc fileprivate func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        
        let collectionView = gesture.view
        
        // figure out which cell were clicking into
        
        var superview = collectionView?.superview
        
        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.item].apps
                
                let fullController = TodayMultipleAppController(mode: .fullscreen)
                fullController.apps = apps
                present(BackEnabledNavController(rootViewController: fullController), animated: true)
                return
            }
            
            superview = superview?.superview
        }
    }
    
    //HandleCloseAnimationOut
    @objc func handleDismissAnimation()
    {
        //animate FullScreen Out
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.bluredVisualEffectView.alpha = 0 // 34an n5fy el blur
            
            self.fullScreenController.view.transform = .identity // 34an nrge3 el view l7gmo 34an el animation yt3ml  sa7
            
            self.fullScreenController.tableView.contentOffset = .zero // nrg3 el tabBar
            
            self.fullScreenController.exitButton.alpha = 0 //34an yfade el button w hwa by2fl
            
            guard let barHeight = self.tabBarController?.tabBar.frame.height else { return } //geting the tabbar height 34an el telphone lma yt8er
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - barHeight // 34an arg3 el tapBar
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
            guard let cell = self.fullScreenController.tableView.cellForRow(at: [0,0]) as? FullScreenHeaderCell else { return }
            cell.todayCell.topConstrains?.constant = 24
            
            self.view.layoutIfNeeded()
            self.fullScreenController.tableView.contentOffset = .zero//lazm t7otha t7t el layoutIfNeeded 34an t4ta8l
           
            
            
            
        }, completion: { (_) in
            self.collectionView.isUserInteractionEnabled = true // bnrg3o 34an el user y3rf ytouch tany
            self.fullScreenController.view?.removeFromSuperview()
            self.fullScreenController.removeFromParent()// 34an lma bn3ml add child lazm nshelo 34an mnfdl4 nadd bss
        })
    }
    
    //ShowMultipleCell
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppController(mode: .fullscreen)
        fullController.apps = items[indexPath.item].apps
        fullController.collectionView.reloadData()
        
        present(BackEnabledNavController(rootViewController: fullController) ,animated: true)
    }
    
    //MARK: ---------- Cell Setup -------------
    
    //cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath) as! TodayBaseCell
        cell.todayItem = items[indexPath.item]
        (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        cell.layer.cornerRadius = 16
        return cell
    }
    
    //sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    //numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    //minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    //insetForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    //didSelectItem
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
             self.showingSingleAppFullScreen(indexPath: indexPath)
        }
    }
    
    //MARK: ----------- Handling the animation Methods --------------
    //Fireing #1 #2 #3
    fileprivate func showingSingleAppFullScreen(indexPath: IndexPath)
    {
        // #1 setup fullscreen Controller View , Save it and send Data
        SetupSingleAppFullScreen(indexPath)
        
        // #2  setup starting postion
        setupAppFullScreenStartingPostion(indexPath)
        
        // #3 BeginAnimation
        self.beginAnimateFullScreenApp(indexPath)
    }
    // #1
    fileprivate func SetupSingleAppFullScreen(_ indexPath: IndexPath)
    {
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = self.items[indexPath.item] // send el data
        appFullScreenController.dismissHandlerr = self.handleDismissAnimation // send el func el htremove
        appFullScreenController.view.layer.cornerRadius = 16
        
        self.fullScreenController = appFullScreenController // to track it
        
        
        // setup the scrollDown for Dismiss :
        
        // #1 setup our pan gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        appFullScreenController.view.addGestureRecognizer(gesture)
        
        // #2 add blur effect
        
        // #3 not to interfere with UItableView Scrolling
    }
    // #2
    fileprivate func setupAppFullScreenStartingPostion(_ indexPath: IndexPath)
    {
        let fullScreenView = fullScreenController.view!
        addChild(fullScreenController) // de 34an t5ly el table view yrender el header wl footer
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {return} // to get the clicked cell
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return} // kda gebna el fram bta3 el cell
        self.startingFrame = startingFrame // local starting frame lel cell
        
        view.addSubview(fullScreenView) //hndeef el view be el frame b2a
        self.anchoredConstraints = fullScreenView.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()//lazm t7otha lma t8er el constrains
        
    }
    // #3
    fileprivate func beginAnimateFullScreenApp(_ indexPath: IndexPath) {
        //animate FullScreen in
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            
            
            self.bluredVisualEffectView.alpha = 1
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height //34an a5fy el tapBar
            
            self.collectionView.isUserInteractionEnabled = false // 34an el user my3ml4 scrol w ybwz el animation
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            guard let cell = self.fullScreenController.tableView.cellForRow(at: [0,0]) as? FullScreenHeaderCell else { return }
            cell.todayCell.topConstrains?.constant = 48
            self.view.layoutIfNeeded()// lazm tst5dmha kol ma t8er el constrains
        }, completion: nil)
    }
    //MARK: ---------------- PanGesture Setups ----------------
    var offsetTracker : CGFloat = 0
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer)
    {
        //beginGesture
        if gesture.state == .began {
            offsetTracker = fullScreenController.tableView.contentOffset.y
        }
        
        //34an ndisable el gesture lma akoon mescrool t7t
        if fullScreenController.tableView.contentOffset.y > 0
        {
            return
        }
        
        let transformY = gesture.translation(in: fullScreenController.view).y
        //Gesturing
        if gesture.state == .changed
        {
            if transformY > 0 {//34an lw 3mlt gesture le fo2 areturn
                
                let trueOffSet = transformY - offsetTracker
                
                var scale = 1 - trueOffSet / 1000
                scale = min(1, scale) // 34an el view mykbar4 aktr mn el 7agm el tby3y bta3o
                scale = max(0.6, scale)//34an mys8r4 awy w invert w ybug w yglitch w hkza
                
                self.fullScreenController.view.transform = .init(scaleX: scale, y: scale)
            }
        }else if gesture.state == .ended
        {
            if transformY > 0 { //34an lw 3mlt gesture le fo2 my3ml4 dismiss
            self.handleDismissAnimation()
            }
        }
    }
    
    // this let us Enable scroll the table view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
