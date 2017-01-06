//
//  ViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 10/31/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    var collectionView : UICollectionView!
    var collectionViewLayout : UPCarouselFlowLayout!
    fileprivate var currentPage : Int = 0
    var panGesture : UIPanGestureRecognizer!
    var currentRotation : Double!
    var spinAnimation : CABasicAnimation!
    var player : AVPlayer!
    var playerController : AVPlayerViewController!
    var numPlays = 1
    
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
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    lazy var createNewGroup : UIButton = {
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
    
    lazy var epicButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("EPIC", for: .normal)
        button.setTitleColor(UIColor.init(netHex: 0xFBC171), for: .normal)
        button.addTarget(self, action: #selector(createNewGroupPressed(sender:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 19)
        return button
    }()
    
    lazy var groupsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Groups", for: .normal)
        button.setTitleColor(UIColor.init(netHex: 0xFAA86F), for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 19)
        return button
    }()
    
    lazy var profileButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Me", for: .normal)
        button.setTitleColor(UIColor.init(netHex: 0xF56D6A), for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 19)
        button.addTarget(self, action: #selector(myProfilePressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.clear), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        currentRotation = 0
        spinAnimation = CABasicAnimation()
        
        setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        setupCreateGroup()
        setupWheelMenu()
    }
    
    func myProfilePressed(sender : AnyObject) {
        let vc = MyProfileViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func createNewGroupPressed(sender : AnyObject) {
        
        let opagueOverlay = UIView()
        opagueOverlay.translatesAutoresizingMaskIntoConstraints = false
        opagueOverlay.layer.cornerRadius = 3
        opagueOverlay.layer.masksToBounds = true
        opagueOverlay.clipsToBounds = false
        opagueOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        
        let epicLogo = UIImageView()
        epicLogo.image = UIImage(named: "epic")
        epicLogo.translatesAutoresizingMaskIntoConstraints = false
        epicLogo.contentMode = .scaleAspectFit
        
        let placeLabel = UILabel()
        placeLabel.text = "Triple C Brewing Company"
        placeLabel.textColor = UIColor.white
        placeLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.textAlignment = .center
        let locationLabel = UILabel()
        locationLabel.text = "Charlotte, NC"
        locationLabel.textColor = UIColor.white
        locationLabel.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .center
        let descriptionLabel = UILabel()
        // only allow 100 characters
        descriptionLabel.text = "If I roll a 7... Deer filter with a small child"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        
        let path = Bundle.main.path(forResource: "snippet", ofType: "mov")
        let url = URL(fileURLWithPath: path!)
        
        player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        playerController.view.frame = self.view.frame
        
        playerController.view.addSubview(epicLogo)
        epicLogo.topAnchor.constraint(equalTo: playerController.view.topAnchor,constant:10).isActive = true
        epicLogo.rightAnchor.constraint(equalTo: playerController.view.rightAnchor,constant:-10).isActive = true
        epicLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        epicLogo.widthAnchor.constraint(equalToConstant: 42).isActive = true

        playerController.view.addSubview(opagueOverlay)
        opagueOverlay.centerXAnchor.constraint(equalTo: playerController.view.centerXAnchor).isActive = true
        opagueOverlay.bottomAnchor.constraint(equalTo: playerController.view.bottomAnchor,constant:-10).isActive = true
        opagueOverlay.widthAnchor.constraint(equalTo: playerController.view.widthAnchor,constant:-20).isActive = true
        opagueOverlay.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        opagueOverlay.addSubview(placeLabel)
        placeLabel.topAnchor.constraint(equalTo: opagueOverlay.topAnchor,constant: 5).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        placeLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        opagueOverlay.addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        opagueOverlay.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: opagueOverlay.bottomAnchor,constant:-5).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        player.play()
        self.present(playerController, animated: true, completion: nil)
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        
        if numPlays < 1 {
            self.player.seek(to: kCMTimeZero)
            self.player.play()
            numPlays = numPlays + 1
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
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

extension ViewController {
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
}

// MARK: - Setup Functions
extension ViewController {
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
        
        view.addSubview(notificationView)
        notificationView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        notificationView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-21.5).isActive = true
        notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        notificationView.addSubview(numNotificationsLabel)
        numNotificationsLabel.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor).isActive = true
        numNotificationsLabel.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor).isActive = true
        numNotificationsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        numNotificationsLabel.widthAnchor.constraint(equalToConstant: 9).isActive = true
        
        view.addSubview(epicButton)
        epicButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-5).isActive = true
        epicButton.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor).isActive = true
        epicButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        epicButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(groupsButton)
        groupsButton.topAnchor.constraint(equalTo: wheelImageView.topAnchor,constant:5).isActive = true
        groupsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        groupsButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(profileButton)
        profileButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:5).isActive = true
        profileButton.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
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




