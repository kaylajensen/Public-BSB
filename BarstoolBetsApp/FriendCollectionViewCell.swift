//
//  FriendCollectionViewCell.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/9/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    var photoId : String?
    
    var photoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = false
        return label
    }()
    
    var gradient : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var photoImageView : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: 80)
        contentView.addSubview(gradient)
        gradient.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        gradient.heightAnchor.constraint(equalToConstant: 80).isActive = true
        gradient.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradient.frame
        gradient.layer.addSublayer(gradientLayer)
        
        gradient.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: gradient.centerXAnchor).isActive = true
        photoLabel.bottomAnchor.constraint(equalTo: gradient.bottomAnchor,constant:-10).isActive = true
        photoLabel.widthAnchor.constraint(equalTo: gradient.widthAnchor).isActive = true
        photoLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
