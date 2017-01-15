//
//  MyProfileViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/6/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    var profileImageView : UIImageView!
    
    lazy var firstLastNameButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Corbin Jensen", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 20)
        return button
    }()
    
    lazy var notificationsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Notifications", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 20)
        return button
    }()
    
    lazy var friendsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Friends", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 20)
        button.addTarget(self, action: #selector(openFriendsView(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 20)
        return button
    }()
    
    lazy var exitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let origImage = UIImage(named: "delete");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(exitButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupProfileImage()
        setupProfileButtons()
    }
    
    func exitButtonPressed(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.clear), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let profileImage = UIImage(named: "profileexample")
        let uiImageView = UIImageView(image: profileImage)
        uiImageView.frame = view.frame
        uiImageView.contentMode = .scaleAspectFill
        view.addSubview(uiImageView)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func setupProfileImage() {
        let size : CGFloat = 189
        
//        let outline = UIImage(named: "white_wheel")
//        let bg = UIImage(named: "sample")
//        let logo = UIImage(named: "filled_wheel")
//        let rect = CGRect(x: 0, y: 0, width: size, height: size)
//        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
//        bg?.draw(in: rect)
//        logo?.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
//        newImage?.draw(in: rect)
//        outline?.draw(in: rect, blendMode: .normal, alpha: 1.0)
//        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        profileImageView = UIImageView(image: finalImage)
        
        profileImageView = UIImageView(image: UIImage(named: "profileexample"))
        profileImageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        profileImageView.layer.cornerRadius = size/2
        profileImageView.layer.masksToBounds = true
        profileImageView.focusOnFaces = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant:-100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
    }
    
    func setupProfileButtons() {
        view.addSubview(firstLastNameButton)
        firstLastNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstLastNameButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:20).isActive = true
        
        view.addSubview(notificationsButton)
        notificationsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notificationsButton.topAnchor.constraint(equalTo: firstLastNameButton.bottomAnchor,constant:10).isActive = true
        
        view.addSubview(friendsButton)
        friendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsButton.topAnchor.constraint(equalTo: notificationsButton.bottomAnchor,constant:10).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.topAnchor.constraint(equalTo: friendsButton.bottomAnchor,constant:10).isActive = true
        
        view.addSubview(exitButton)
        exitButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-10).isActive = true
        exitButton.topAnchor.constraint(equalTo: view.topAnchor,constant:10).isActive = true
    }
}

// MARK: Handlers
extension MyProfileViewController {
    func openFriendsView(sender: AnyObject) {
        print("did click open friends view controller")
        let vc = FriendsCollectionViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
