//
//  CreateGroupViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/7/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
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
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        //self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createGroupPressed(sender:)))
        
        setupBasicView()
    }
    
    func createGroupPressed(sender : AnyObject) {
        
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
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }


}
