//
//  CreateGroupFriendCollectionViewCell.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/13/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class CreateGroupFriendCollectionViewCell: UICollectionViewCell {
    var photoId : String?
    
    var photoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        label.textColor = UIColor.white
        label.textAlignment = .center
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
    
    var photoImageView : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var moreInfo : UILabel = {
        let image = UILabel()
        image.text = "+"
        image.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        image.textColor = UIColor.white
        image.textAlignment = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        
        contentView.addSubview(gradient)
        gradient.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        gradient.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        gradient.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        gradient.addSubview(moreInfo)
        moreInfo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        moreInfo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        moreInfo.heightAnchor.constraint(equalToConstant: 32).isActive = true
        moreInfo.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        gradient.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        photoLabel.topAnchor.constraint(equalTo: moreInfo.bottomAnchor,constant:-5).isActive = true
        photoLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant:-5).isActive = true
        photoLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
