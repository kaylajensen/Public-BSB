//
//  GroupViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/14/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var chatTableView : UITableView!
    var reuseIdentifier = "chatCell"
    var collectionView : UICollectionView!
    var groupName = ""
    
    var groupTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
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
    
    lazy var showMoreChatMessagesButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "large_ellipsis"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupTitleView()
        setupChatTableView()
        setupCollectionView()
        
        groupTitleLabel.text = groupName
    }
    
    func setupTitleView() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        view.addSubview(groupTitleLabel)
        groupTitleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:15).isActive = true
        groupTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.6).isActive = true
        groupTitleLabel.heightAnchor.constraint(equalToConstant:27).isActive = true
    }
    
    func setupCollectionView() {
        let screenWidth = view.frame.size.width - 7.5
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        flowLayout.minimumInteritemSpacing = 2.5
        flowLayout.minimumLineSpacing = 2.5
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height/2)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: flowLayout)
        collectionView.register(BetFriendCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: showMoreChatMessagesButton.bottomAnchor,constant:15).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupChatTableView() {
        let tableViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 240)
        chatTableView = UITableView(frame: tableViewFrame, style: .plain)
        chatTableView.backgroundColor = UIColor.white
        chatTableView.separatorStyle = .none
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.showsVerticalScrollIndicator = false
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        chatTableView.allowsSelection = false
        view.addSubview(chatTableView)
        
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor,constant:15).isActive = true
        chatTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chatTableView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        chatTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(showMoreChatMessagesButton)
        showMoreChatMessagesButton.topAnchor.constraint(equalTo: chatTableView.bottomAnchor,constant:15).isActive = true
        showMoreChatMessagesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showMoreChatMessagesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        showMoreChatMessagesButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
}

extension GroupViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        
        if indexPath.row%2 == 0 {
            cell.chatMessage.text = "Kayla bet Corbin to chug an entire beer."
            cell.chatMessage.textAlignment = .right
            cell.myDiceRolledLabel.text = "7"
            cell.myChatBubble.isHidden = false
            cell.friendChatBubble.isHidden = true
        } else {
            cell.chatMessage.text = "Corbin bet Kayla to leave Starbucks now."
            cell.chatMessage.textAlignment = .left
            cell.friendDiceRolledLabel.text = "3"
            cell.myChatBubble.isHidden = true
            cell.friendChatBubble.isHidden = false
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: CollectionView Delegate and DataSource
extension GroupViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BetFriendCollectionViewCell
        
        cell.photoLabel.text = names[indexPath.row]
        
//        if indexPath.row == 5 {
//            cell.setUsersTurn()
//            cell.photoLabel.text = names[indexPath.row] + "'s Turn"
//        }
        
        if indexPath.row % 2 == 0 {
            cell.photoImageView.image = UIImage(named: "sample")
        } else {
            cell.photoImageView.image = UIImage(named: "matt")
        }
        
        cell.photoImageView.focusOnFaces = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

