//
//  ViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 10/31/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    var createGroupViewController = CreateGroupViewController()
    var myProfileViewController = MyProfileViewController()
    var collectionView : UICollectionView!
    var collectionViewLayout : UPCarouselFlowLayout!
    fileprivate var currentPage : Int = 0
    var panGesture : UIPanGestureRecognizer!
    var currentRotation : Double!
    var spinAnimation : CABasicAnimation!
    
    fileprivate var groupNames = ["Slim Shady 3's","The Transformers","The Aristacrats","The Mizspellers","The Bosses","The Nascar Peeps"]
    
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
    
    lazy var newGroupTabButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "create_group_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.addTarget(self, action: #selector(createGroupButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var groupsTabButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "groups_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
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
        
        setupSwipeControl()

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
    }
}

// MARK : Handlers
extension GroupsViewController {
    
    func epicBetsPressed(sender : AnyObject) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func myProfilePressed(sender : AnyObject) {
        self.navigationController?.present(myProfileViewController, animated: true, completion: nil)
    }
    
    func createGroupButtonPressed(sender : AnyObject) {
        self.navigationController?.present(createGroupViewController, animated: true,completion: nil)
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
        return groupNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
        cell.groupImage.image = UIImage(named: "gradient_barstool")
        cell.groupName.text = groupNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let group = groupNames[(indexPath as NSIndexPath).row]
        let alert = UIAlertController(title: group, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
    }
    
    func setupSwipeControl() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(recognizer:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        swipeLeft.delegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(recognizer:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        swipeRight.delegate = self
        
    }
    
    func swipeRight(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func swipeLeft(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 0
    }
    
    func setupTabIcons() {
        let iconsHeightWidth : CGFloat = 75
        
        view.addSubview(newGroupTabButton)
        newGroupTabButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGroupTabButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-15).isActive = true
        newGroupTabButton.heightAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        newGroupTabButton.widthAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        
        view.addSubview(groupsTabButton)
        groupsTabButton.rightAnchor.constraint(equalTo: newGroupTabButton.leftAnchor,constant:-40).isActive = true
        groupsTabButton.bottomAnchor.constraint(equalTo: newGroupTabButton.centerYAnchor).isActive = true
        groupsTabButton.heightAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        groupsTabButton.widthAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        
        let groupsLabel = UILabel()
        groupsLabel.text = "Groups"
        groupsLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        groupsLabel.textColor = BSB_RED
        groupsLabel.textAlignment = .center

        view.addSubview(groupsLabel)
        groupsLabel.translatesAutoresizingMaskIntoConstraints = false
        groupsLabel.centerXAnchor.constraint(equalTo: groupsTabButton.centerXAnchor).isActive = true
        groupsLabel.topAnchor.constraint(equalTo: groupsTabButton.bottomAnchor,constant:-15).isActive = true
        groupsLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        groupsLabel.widthAnchor.constraint(equalTo: groupsTabButton.widthAnchor).isActive = true
        
        view.addSubview(epicTabButton)
        epicTabButton.leftAnchor.constraint(equalTo: newGroupTabButton.rightAnchor,constant:40).isActive = true
        epicTabButton.bottomAnchor.constraint(equalTo: newGroupTabButton.centerYAnchor).isActive = true
        epicTabButton.heightAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        epicTabButton.widthAnchor.constraint(equalToConstant: iconsHeightWidth).isActive = true
        
        let epicLabel = UILabel()
        epicLabel.text = "Epic"
        epicLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 10)
        epicLabel.textColor = BSB_YELLOW
        epicLabel.textAlignment = .center
        
        view.addSubview(epicLabel)
        epicLabel.translatesAutoresizingMaskIntoConstraints = false
        epicLabel.centerXAnchor.constraint(equalTo: epicTabButton.centerXAnchor).isActive = true
        epicLabel.topAnchor.constraint(equalTo: epicTabButton.bottomAnchor,constant:-15).isActive = true
        epicLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        epicLabel.widthAnchor.constraint(equalTo: epicTabButton.widthAnchor).isActive = true
    }
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.white
        
        collectionViewLayout = UPCarouselFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = CGSize(width: view.frame.width, height: 250)
        collectionViewLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 50)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 260)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
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
        
        self.currentPage = 0
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
