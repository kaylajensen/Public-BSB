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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupProfileImage()
        setupProfileButtons()
    }
    
    func backButtonPressed() {
        
    }
    
    func setupBackground() {
        //view.backgroundColor = UIColor.init(netHex: 0x312308).withAlphaComponent(0.0)
        view.backgroundColor = UIColor.clear
        
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
        
        let outline = UIImage(named: "white_wheel")
        let bg = UIImage(named: "profileexample")
        let logo = UIImage(named: "filled_wheel")
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        bg?.draw(in: rect)
        logo?.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        newImage?.draw(in: rect)
        outline?.draw(in: rect, blendMode: .normal, alpha: 1.0)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        profileImageView = UIImageView(image: finalImage)
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
        
    }
    


}