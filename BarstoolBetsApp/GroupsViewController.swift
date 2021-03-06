//
//  ViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 10/31/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    var swipeDown : UIButton!
    var swipeLeft : UIButton!
    var swipeRight : UIButton!
    
    var createGroupViewController = CreateGroupViewController()
    var myProfileViewController = MyProfileViewController()
    var collectionView : UICollectionView!
    var collectionViewLayout : UPCarouselFlowLayout!
    fileprivate var currentPage : Int = 0
    var panGesture : UIPanGestureRecognizer!
    var currentRotation : Double!
    var spinAnimation : CABasicAnimation!
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    lazy var notieTabButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "notie_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.addTarget(self, action: #selector(notieButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var groupsTabButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "groups_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        return button
    }()
    
    lazy var epicTabButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "epic_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.addTarget(self, action: #selector(epicBetsPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var notificationView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 19/2
        view.backgroundColor = BSB_RED
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 4
        return view
    }()
    
    lazy var profileViewContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 77/2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        return view
    }()
    
    lazy var profileImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileexample")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowColor = UIColor.lightGray.cgColor
        image.layer.shadowOpacity = 0.8
        image.layer.shadowOffset = CGSize(width: 3, height: 3)
        image.layer.shadowRadius = 4
        image.layer.masksToBounds = false
        image.clipsToBounds = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(myProfilePressed(sender:)))
        image.addGestureRecognizer(gesture)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.clear), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        currentRotation = 0
        spinAnimation = CABasicAnimation()
        
        setupCollectionView()
        
        setupTabIcons()
        setupProfileTabView()
        
        hideAllHintArrows()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        collectionView.reloadData()
    }
}

// MARK : Handlers
extension GroupsViewController {
    func hideAllHintArrows() {
        swipeDown.isHidden = true
    }
    
    func epicBetsPressed(sender : AnyObject) {
        print("epic bets tab pressed")
    }
    
    func myProfilePressed(sender : AnyObject) {
        print("my profile photo pressed")
    }
    
    func notieButtonPressed(sender : AnyObject) {
        print("notie view pressed")
    }
    
    func createFirstGroupButtonPressed(sender : AnyObject) {
        self.present(createGroupViewController, animated: true, completion: nil)
    }
    
    func didRotateWheel(sender : UIPanGestureRecognizer) {
        if sender.state == .ended {
            spinAnimation.fromValue = currentRotation
            let rotationAmount = M_PI*2/6
            let wheelImageView = UIImageView(image: UIImage(named: "wheel"))
            if sender.velocity(in: wheelImageView).x > 0 {
                // went right
                currentRotation = currentRotation + rotationAmount
                spinAnimation.toValue = currentRotation
            } else {
                // went left
                currentRotation = currentRotation - rotationAmount
                spinAnimation.toValue = currentRotation
            }
            
            spinAnimation.duration = 0.22
            spinAnimation.repeatCount = 0
            spinAnimation.isRemovedOnCompletion = false
            spinAnimation.fillMode = kCAFillModeForwards
            spinAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            wheelImageView.layer.add(spinAnimation, forKey: "transform.rotation.z")
        }
    }
}

extension GroupsViewController {
    // MARK: - Card Collection Delegate & DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groupNames.count == 0 {
            return 1
        }
        return groupNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if groupNames.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyGroupStateCollectionViewCell.identifier, for: indexPath) as! EmptyGroupStateCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
            cell.groupName.text = groupNames[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if groupNames.count == 0 {
            createFirstGroupButtonPressed(sender: self)
        } else {
            let group = groupNames[indexPath.row]
            let groupViewController = GroupViewController()
            groupViewController.groupName = group
            self.present(groupViewController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
}

// MARK: - Setup Functions
extension GroupsViewController {
    
    func setupProfileTabView() {
        view.addSubview(profileViewContainer)
        profileViewContainer.topAnchor.constraint(equalTo: view.topAnchor,constant:20).isActive = true
        profileViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileViewContainer.heightAnchor.constraint(equalToConstant: 77).isActive = true
        profileViewContainer.widthAnchor.constraint(equalToConstant: 77).isActive = true
        
        profileViewContainer.isHidden = true
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: profileViewContainer.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileViewContainer.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileViewContainer.heightAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileViewContainer.widthAnchor).isActive = true
        
        view.addSubview(notificationView)
        notificationView.topAnchor.constraint(equalTo: profileViewContainer.topAnchor).isActive = true
        notificationView.rightAnchor.constraint(equalTo: profileViewContainer.rightAnchor).isActive = true
        notificationView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        notificationView.widthAnchor.constraint(equalToConstant: 19).isActive = true
        
        swipeDown = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let origImage = UIImage(named: "swipe_down_arrow")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        swipeDown.setImage(tintedImage, for: .normal)
        swipeDown.tintColor = UIColor.black.withAlphaComponent(0.1)
        swipeDown.contentMode = .scaleAspectFit
        swipeDown.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(swipeDown)
        swipeDown.centerXAnchor.constraint(equalTo: profileViewContainer.centerXAnchor).isActive = true
        swipeDown.topAnchor.constraint(equalTo: profileViewContainer.bottomAnchor).isActive = true
        swipeDown.widthAnchor.constraint(equalToConstant: 50).isActive = true
        swipeDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func setupTabIcons() {
        let iconsHeight : CGFloat = 70
        //54.69
        let iconsWidth : CGFloat = 84
        //57.24
        
        view.addSubview(groupsTabButton)
        groupsTabButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupsTabButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-15).isActive = true
        groupsTabButton.heightAnchor.constraint(equalToConstant: iconsHeight).isActive = true
        groupsTabButton.widthAnchor.constraint(equalToConstant: iconsWidth).isActive = true
        
        view.addSubview(epicTabButton)
        epicTabButton.leftAnchor.constraint(equalTo: groupsTabButton.rightAnchor,constant:30).isActive = true
        epicTabButton.bottomAnchor.constraint(equalTo: groupsTabButton.centerYAnchor).isActive = true
        epicTabButton.heightAnchor.constraint(equalToConstant: iconsHeight).isActive = true
        epicTabButton.widthAnchor.constraint(equalToConstant: iconsWidth).isActive = true
        
        view.addSubview(notieTabButton)
        notieTabButton.rightAnchor.constraint(equalTo: groupsTabButton.leftAnchor,constant:-30).isActive = true
        notieTabButton.bottomAnchor.constraint(equalTo: groupsTabButton.centerYAnchor).isActive = true
        notieTabButton.heightAnchor.constraint(equalToConstant: iconsHeight).isActive = true
        notieTabButton.widthAnchor.constraint(equalToConstant: iconsWidth).isActive = true
        
    }
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.white
        
        collectionViewLayout = UPCarouselFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = CGSize(width: view.frame.width/1.7, height: 250)
        collectionViewLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 75)
        collectionViewLayout.sideItemAlpha = 0.18
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 260)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EmptyGroupStateCollectionViewCell.self, forCellWithReuseIdentifier: EmptyGroupStateCollectionViewCell.identifier)
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
