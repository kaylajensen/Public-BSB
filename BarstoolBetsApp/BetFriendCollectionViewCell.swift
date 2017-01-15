//
//  CreateGroupFriendCollectionViewCell.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/13/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class BetFriendCollectionViewCell: UICollectionViewCell {
    var photoId : String?
    
    var photoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var gradient : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    var usersTurnGradient : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    var photoImageView : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var betIcon : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bet_icon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
    
        setupBetView()
    }
    
    func setupBetView() {
        contentView.addSubview(gradient)
        gradient.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        gradient.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        gradient.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        gradient.addSubview(betIcon)
        betIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        betIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        betIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        betIcon.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        gradient.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        photoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:-5).isActive = true
        photoLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant:-10).isActive = true
        photoLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func setUsersTurn() {
        gradient.removeFromSuperview()
        
        contentView.addSubview(usersTurnGradient)
        usersTurnGradient.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        usersTurnGradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        usersTurnGradient.heightAnchor.constraint(equalToConstant: 32).isActive = true
        usersTurnGradient.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        usersTurnGradient.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: usersTurnGradient.centerXAnchor).isActive = true
        photoLabel.centerYAnchor.constraint(equalTo: usersTurnGradient.centerYAnchor).isActive = true
        photoLabel.widthAnchor.constraint(equalTo: usersTurnGradient.widthAnchor,constant:-10).isActive = true
        photoLabel.heightAnchor.constraint(equalTo: usersTurnGradient.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
