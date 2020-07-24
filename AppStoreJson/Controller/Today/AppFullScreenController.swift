//
//  AppFullScreenController.swift
//  AppStoreJson
//
//  Created by samer on 7/20/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class AppFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: ----------- Variables --------------
    @objc var dismissHandlerr: (() -> ())?
    
    var todayItem : TodayItem?
    
    let tableView = UITableView(frame: .zero, style: .plain) // add tableView manualy
    
    let exitButton : UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        b.addTarget(self, action: #selector(dismissHandler) , for: .touchUpInside)
        return b
    }()
    //MARK: ----------- conponts for the slide up blured view --------------
    let floatingContainerView : UIView = {
        let v = UIView()
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        return v
    }()
    let imageView : UIImageView = {
        let i = UIImageView()
        i.clipsToBounds = true
        i.layer.cornerRadius = 5
        i.widthAnchor.constraint(equalToConstant: 50).isActive  = true
        i.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        i.contentMode = .scaleAspectFill
        return i
    }()
    let titleLable: UILabel = {
       let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.text = "Life Hack"
        return l
    }()
    let disLable: UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Utilize your Time"
        return l
    }()
    let getButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("GET", for: .normal)
        b.backgroundColor = #colorLiteral(red: 0.3411515355, green: 0.3411949277, blue: 0.3411320746, alpha: 1)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 15
        b.heightAnchor.constraint(equalToConstant: 30).isActive = true
        b.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return b
    }()
    
    //MARK: ----------- viewDidLoad --------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        setupExitButton()
        
        tableView.dataSource = self//dol 34an el data tezhar b2a w t3mlha lma ykon el table m3mol manual
        tableView.delegate = self
        tableView.tableFooterView = UIView() //34an nel8y el 5toot bta3t el table view
        tableView.separatorStyle = .none //34an nel8y el 5toot bta3t el table view
        tableView.allowsSelection = false //34an n5ly el user y2dr ytouch
        tableView.showsVerticalScrollIndicator = false // n5fy el croll bar
        tableView.contentInsetAdjustmentBehavior = .never // kda msh hy3ml e3tbar lel safe area
        
        let height = UIApplication.shared.statusBarFrame.height //tool el status bar 34an nb3d el content 3no
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        
        setupBluredView()
        imageView.image = todayItem?.image
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //da 34an el sismiss animation myscrolle4 wna bdissmiss bel drag
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true//de 34an lw el dissmiss etl8a a2dr escroll brdo
        }
        let transY = -80 - UIApplication.shared.statusBarFrame.height
        
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: transY) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.floatingContainerView.transform = transform
        })
        
    }
    //MARK: ----------- TableViewCells --------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {//The Header
            //hack for adding the cell to cell
            let cell = FullScreenHeaderCell()
            cell.clipsToBounds = true // 34an el shadow y5tfy lma el controller yft7
            cell.todayCell.todayItem = self.todayItem
            return cell
        }
        else{
            let cell = FullScreenDescibtionCell()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }
    
    //MARK: ----------- Methods --------------
    //DismissHandle
    @objc fileprivate func dismissHandler(Button:UIButton){
        dismissHandlerr?()
    }
    
    //ExitButton
    fileprivate func setupExitButton(){
        view.addSubview(exitButton)
        exitButton.anchorBySize(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 8), size: CGSize(width: 80, height: 38))
    }
    
    //Blured View
    fileprivate func setupBluredView()
    {
        view.addSubview(floatingContainerView)
        
        floatingContainerView.anchorBySize(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -80, right: 16), size: .init(width: 0, height: 80))
        
        let bluredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        floatingContainerView.addSubview(bluredView)
        bluredView.fillSuperview()
        
        
        let lableStack = CustomStackView(arrangedSubviews: [titleLable,disLable], spacing: 5, axis: .vertical, dis: .fill)
        let allStack = CustomStackView(arrangedSubviews: [imageView,lableStack,getButton], spacing: 10, axis: .horizontal, dis: .fill)
        allStack.alignment = .center


        floatingContainerView.addSubview(allStack)
        allStack.fillSuperview(padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        
    }
}
