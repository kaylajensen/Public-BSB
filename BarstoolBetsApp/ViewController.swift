//
//  ViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 10/31/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    var barstoolImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "barstool")
        return image
    }()
    
    var groupContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var groupNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Slim Shady 3's"
        let font = UIFont(name: "HelveticaNeue-Thin", size: 34.0)!
        label.textAlignment = .center
        label.font = font
        return label
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
        return image
    }()
    
    var notificationView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 12.5
        view.backgroundColor = UIColor.init(netHex: 0xF8926D)
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBarstools()
        setupCreateGroup()
        setupWheelMenu()
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    func setupBarstools() {
        view.addSubview(groupContainer)
        groupContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        groupContainer.widthAnchor.constraint(equalToConstant: 258).isActive = true
        groupContainer.heightAnchor.constraint(equalToConstant: 164).isActive = true

        groupContainer.addSubview(barstoolImageView)
        barstoolImageView.centerXAnchor.constraint(equalTo: groupContainer.centerXAnchor).isActive = true
        barstoolImageView.topAnchor.constraint(equalTo: groupContainer.topAnchor).isActive = true
        barstoolImageView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        barstoolImageView.widthAnchor.constraint(equalToConstant: 89).isActive = true
        
        groupContainer.addSubview(groupNameLabel)
        groupNameLabel.centerXAnchor.constraint(equalTo: groupContainer.centerXAnchor).isActive = true
        groupNameLabel.bottomAnchor.constraint(equalTo: groupContainer.bottomAnchor).isActive = true
        groupNameLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        groupNameLabel.widthAnchor.constraint(equalTo: groupContainer.widthAnchor).isActive = true
        
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
        wheelImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:173).isActive = true
        wheelImageView.heightAnchor.constraint(equalToConstant: 313).isActive = true
        wheelImageView.widthAnchor.constraint(equalToConstant: 313).isActive = true
        
        wheelImageView.addSubview(notificationView)
        notificationView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        notificationView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-21.5).isActive = true
        notificationView.centerXAnchor.constraint(equalTo: wheelImageView.centerXAnchor,constant:-66).isActive = true
        
        notificationView.addSubview(numNotificationsLabel)
        numNotificationsLabel.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor).isActive = true
        numNotificationsLabel.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor).isActive = true
        numNotificationsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        numNotificationsLabel.widthAnchor.constraint(equalToConstant: 9).isActive = true
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




