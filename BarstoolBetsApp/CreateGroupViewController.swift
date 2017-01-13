//
//  CreateGroupViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/7/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UIGestureRecognizerDelegate, UINavigationBarDelegate {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.text = "Create Group"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var groupNameTextView : UITextField = {
        let field = UITextField()
        field.placeholder = "Group Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.defaultTextAttributes = [NSFontAttributeName : UIFont.init(name: "HelveticaNeue-Thin", size: 17)!]
        field.textColor = UIColor.black
        field.autocapitalizationType = .words
        field.keyboardAppearance = .dark
        return field
    }()
    
    var friendsAddedLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
        label.text = "Friends Added"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gradientSeparator : UIImageView = {
        let view = UIImageView(image: UIImage(named: "gradient_line"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwipeControl()

        view.backgroundColor = UIColor.white

        self.navigationController?.navigationBar.isHidden = true
        
        setupBasicView()
    }
    
    func swipeRight(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 2
    }
    
    func swipeLeft(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func createGroupPressed(sender : AnyObject) {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        groupNameTextView.resignFirstResponder()
    }

}

// MARK : Setup
extension CreateGroupViewController {
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
    
    func setupBasicView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.6).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:54).isActive = true
        
        view.addSubview(groupNameTextView)
        groupNameTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant:25).isActive = true
        groupNameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupNameTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        groupNameTextView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.85).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor.lightGray
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: groupNameTextView.centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: groupNameTextView.bottomAnchor,constant: 4).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(friendsAddedLabel)
        friendsAddedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsAddedLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor,constant:40).isActive = true
        friendsAddedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        friendsAddedLabel.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
        
        view.addSubview(gradientSeparator)
        gradientSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gradientSeparator.topAnchor.constraint(equalTo: friendsAddedLabel.bottomAnchor,constant:4).isActive = true
        gradientSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        gradientSeparator.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
    }
}
