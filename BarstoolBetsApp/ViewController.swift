//
//  ViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 10/31/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    var createNewGroup : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        let font = UIFont(name: "HelveticaNeue-UltraLight", size: 47.0)!
        let color = UIColor(netHex: 0xF56D6A)
        button.setTitleColor(color, for: .normal)
        button.titleLabel!.font = font
        return button
    }()
    
    var numNotificationsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7"
        let font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = font
        return label
    }()
    
    var wheelImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "wheel")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var notificationView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 17.5
        view.backgroundColor = UIColor.init(netHex: 0xF8926D)
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        currentRotation = 0
        spinAnimation = CABasicAnimation()
        
        setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        setupCreateGroup()
        setupWheelMenu()
    }
    
    
    var collectionView : UICollectionView!
    var collectionViewLayout : UPCarouselFlowLayout!
    
    fileprivate var groupNames = ["Slim Shady 3's","The Transformers","The Aristacrats","The Mizspellers","The Bosses","The Nascar Peeps"]
    
    fileprivate var currentPage : Int = 0
    
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
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.white
        
        collectionViewLayout = UPCarouselFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: 250)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 325)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.setupLayout()
        self.currentPage = 0
    }
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    @objc fileprivate func rotationDidChange() {
        guard !orientation.isFlat else { return }
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let direction: UICollectionViewScrollDirection = UIDeviceOrientationIsPortrait(orientation) ? .horizontal : .vertical
        layout.scrollDirection = direction
        if currentPage > 0 {
            let indexPath = IndexPath(item: currentPage, section: 0)
            let scrollPosition: UICollectionViewScrollPosition = UIDeviceOrientationIsPortrait(orientation) ? .centeredHorizontally : .centeredVertically
            self.collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        }
    }
    
    // MARK: - Card Collection Delegate & DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
        cell.groupImage.image = UIImage(named: "barstool")
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
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    func setupCreateGroup() {
        view.addSubview(createNewGroup)
        createNewGroup.heightAnchor.constraint(equalToConstant: 54).isActive = true
        createNewGroup.widthAnchor.constraint(equalToConstant: 29).isActive = true
        createNewGroup.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        createNewGroup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupWheelMenu() {
        view.addSubview(wheelImageView)
        wheelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let approxWidth = view.frame.width
        wheelImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: approxWidth/1.9).isActive = true
        wheelImageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        wheelImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(didRotateWheel(sender:)))
        wheelImageView.addGestureRecognizer(panGesture)
        
        wheelImageView.addSubview(notificationView)
        notificationView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        notificationView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-21.5).isActive = true
        notificationView.centerXAnchor.constraint(equalTo: wheelImageView.centerXAnchor).isActive = true
        
        notificationView.addSubview(numNotificationsLabel)
        numNotificationsLabel.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor).isActive = true
        numNotificationsLabel.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor).isActive = true
        numNotificationsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        numNotificationsLabel.widthAnchor.constraint(equalToConstant: 9).isActive = true
    }
    
    var panGesture : UIPanGestureRecognizer!
    var currentRotation : Double!
    var spinAnimation : CABasicAnimation!
    func didRotateWheel(sender : UIPanGestureRecognizer) {
        
        if sender.state == .ended {
            spinAnimation.fromValue = currentRotation
            let rotationAmount = M_PI*2/6
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




