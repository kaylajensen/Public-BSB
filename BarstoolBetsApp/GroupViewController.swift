//
//  GroupViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/14/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    var chatTableView : UITableView!
    var groupName = ""
    
    var groupTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.text = "Create Group"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        //button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupTitleView()
        
        groupTitleLabel.text = groupName
    }
    
    func setupTitleView() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        view.addSubview(groupTitleLabel)
        groupTitleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:15).isActive = true
        groupTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.6).isActive = true
        groupTitleLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
//        view.addSubview(backButton)
//        backButton.centerYAnchor.constraint(equalTo: groupTitleLabel.centerYAnchor).isActive = true
//        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:15).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupChatTableView() {
        
    }
}
