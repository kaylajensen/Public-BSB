//
//  ChatTableViewCell.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/15/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var myChatBubble : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BSB_RED
        view.layer.cornerRadius = 27/2
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        return view
    }()
    
    var friendChatBubble : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 27/2
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        return view
    }()
    
    var friendDiceRolledLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    var myDiceRolledLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    var chatMessage : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(myChatBubble)
        myChatBubble.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant:-5).isActive = true
        myChatBubble.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        myChatBubble.heightAnchor.constraint(equalToConstant: 27).isActive = true
        myChatBubble.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        myChatBubble.addSubview(myDiceRolledLabel)
        myDiceRolledLabel.centerXAnchor.constraint(equalTo: myChatBubble.centerXAnchor).isActive = true
        myDiceRolledLabel.centerYAnchor.constraint(equalTo: myChatBubble.centerYAnchor).isActive = true
        
        contentView.addSubview(friendChatBubble)
        friendChatBubble.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant:5).isActive = true
        friendChatBubble.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        friendChatBubble.heightAnchor.constraint(equalToConstant: 27).isActive = true
        friendChatBubble.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        friendChatBubble.addSubview(friendDiceRolledLabel)
        friendDiceRolledLabel.centerXAnchor.constraint(equalTo: friendChatBubble.centerXAnchor).isActive = true
        friendDiceRolledLabel.centerYAnchor.constraint(equalTo: friendChatBubble.centerYAnchor).isActive = true
        
        contentView.addSubview(chatMessage)
        chatMessage.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant:-74).isActive = true
        chatMessage.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant:-4).isActive = true
        chatMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        chatMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
