//
//  FriendProfileViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/14/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController {

    var profileImageView : UIImageView!
    var friendFirstLastName = ""
    var friendFirstName = ""
    
    var friendFirstLastNameLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var betFriendLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var removeFriendLabel : UILabel = {
        let label = UILabel()
        label.textColor = BSB_RED
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupProfile()
        setupNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        friendFirstLastNameLabel.text = friendFirstLastName
        betFriendLabel.text = "Bet " + friendFirstName
        removeFriendLabel.text = "Remove " + friendFirstName
    }
    
    func backButtonPressed(sender : AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupNav() {
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor,constant:15).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:15).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupProfile() {
        let size : CGFloat = 189
        
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
        
        view.addSubview(friendFirstLastNameLabel)
        friendFirstLastNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendFirstLastNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:15).isActive = true
        friendFirstLastNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        friendFirstLastNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-30).isActive = true
        
        view.addSubview(betFriendLabel)
        betFriendLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        betFriendLabel.topAnchor.constraint(equalTo: friendFirstLastNameLabel.bottomAnchor,constant:50).isActive = true
        betFriendLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        betFriendLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-30).isActive = true
        
        view.addSubview(removeFriendLabel)
        removeFriendLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        removeFriendLabel.topAnchor.constraint(equalTo: betFriendLabel.bottomAnchor,constant:50).isActive = true
        removeFriendLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        removeFriendLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-30).isActive = true
        
    }

}
