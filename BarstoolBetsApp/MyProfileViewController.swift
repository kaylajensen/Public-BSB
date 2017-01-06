//
//  MyProfileViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/6/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProfileImage()
        view.backgroundColor = UIColor.init(netHex: 0x312308).withAlphaComponent(0.7)
        
    }
    
    func setupProfileImage() {
        
        let logo = UIImage(named: "profileexample")
        let bg = UIImage(named: "white_wheel")
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200))
        bg?.draw(in: rect)
        logo?.draw(in: rect, blendMode: .sourceIn, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let profileImageView = UIImageView(image: newImage)
        
        view.addSubview(profileImageView)
    }


}
