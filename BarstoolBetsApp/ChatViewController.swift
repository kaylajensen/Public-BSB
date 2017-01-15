//
//  ChatViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/15/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chatTableView : UITableView!
    var reuseIdentifier = "chatCell"
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
    
    lazy var sendMessageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send_message_icon"), for: .normal)
        button.addTarget(self, action: #selector(sendNewMessagePressed(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var newMessageTextView : UITextField = {
        let textView = UITextField()
        textView.placeholder = "Send Message..."
        textView.contentMode = .left
        textView.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        textView.textColor = UIColor.black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7.5, height: 40))
        textView.leftViewMode = .always
        textView.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 40))
        textView.rightViewMode = .always
        return textView
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var gradientSeparator : UIImageView = {
        let view = UIImageView(image: UIImage(named: "gradient_line"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupTitleView()
        setupChatTableView()
        groupTitleLabel.text = groupName
    }
    
    func setupTitleView() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        view.addSubview(groupTitleLabel)
        groupTitleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:15).isActive = true
        groupTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.6).isActive = true
        groupTitleLabel.heightAnchor.constraint(equalToConstant:27).isActive = true
        
        view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:15).isActive = true
        backButton.centerYAnchor.constraint(equalTo: groupTitleLabel.centerYAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupChatTableView() {
        let tableViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.54)
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
        chatTableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier:0.54).isActive = true
        chatTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(gradientSeparator)
        gradientSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gradientSeparator.topAnchor.constraint(equalTo: chatTableView.bottomAnchor,constant:4).isActive = true
        gradientSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        gradientSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(newMessageTextView)
        newMessageTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newMessageTextView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        newMessageTextView.topAnchor.constraint(equalTo: gradientSeparator.bottomAnchor,constant:4).isActive = true
        newMessageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        newMessageTextView.addSubview(sendMessageButton)
        sendMessageButton.centerYAnchor.constraint(equalTo: newMessageTextView.centerYAnchor).isActive = true
        sendMessageButton.rightAnchor.constraint(equalTo: newMessageTextView.rightAnchor,constant:-7.5).isActive = true
        sendMessageButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
        sendMessageButton.widthAnchor.constraint(equalToConstant: 37).isActive = true
        
    }
    
    func sendNewMessagePressed(sender: AnyObject) {
        print("send new message button pressed")
    }
    
    func backButtonPressed(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK : Chat Table View DataSource and Delegate
extension ChatViewController {
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
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

