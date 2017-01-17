//
//  EmptyGroupStateCollectionViewCell.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/4/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class EmptyGroupStateCollectionViewCell: UICollectionViewCell {
    
    var groupImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "empty_state_no_groups")
        return image
    }()
    
    var groupName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.text = "Create your first group!"
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    static let identifier = "EmptyGroupStateCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.addSubview(groupImage)
        self.addSubview(groupName)
        
        groupImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        groupImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        groupImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        groupImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        groupName.topAnchor.constraint(equalTo: groupImage.bottomAnchor).isActive = true
        groupName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        groupName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        groupName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
    }
}
