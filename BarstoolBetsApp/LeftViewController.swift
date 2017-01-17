//
//  LeftViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/14/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    var videoDemoThumbnail : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bsb_demo_video")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var profileViewContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 77/2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        return view
    }()
    
    lazy var profileImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileexample")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.clipsToBounds = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var pendingBetsLabel : UILabel = {
        let label = UILabel()
        label.text = "Pending Bets"
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var videoDemoLabel : UILabel = {
        let label = UILabel()
        label.text = "Rules"
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var yourScoreLabel : UILabel = {
        let label = UILabel()
        label.text = "Your Score"
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var scoreAmount : UILabel = {
        let label = UILabel()
        label.text = "397"
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 38)
        label.textColor = BSB_RED
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(profileViewContainer)
        profileViewContainer.topAnchor.constraint(equalTo: view.topAnchor,constant:20).isActive = true
        profileViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileViewContainer.heightAnchor.constraint(equalToConstant: 77).isActive = true
        profileViewContainer.widthAnchor.constraint(equalToConstant: 77).isActive = true
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: profileViewContainer.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileViewContainer.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileViewContainer.heightAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileViewContainer.widthAnchor).isActive = true
        
        view.addSubview(pendingBetsLabel)
        pendingBetsLabel.topAnchor.constraint(equalTo: profileViewContainer.bottomAnchor,constant:5).isActive = true
        pendingBetsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pendingBetsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pendingBetsLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-40).isActive = true
        
        let lineSeparator = UIView()
        lineSeparator.backgroundColor = BSB_RED
        lineSeparator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineSeparator)
        lineSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineSeparator.topAnchor.constraint(equalTo: pendingBetsLabel.bottomAnchor,constant:3).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(videoDemoLabel)
        videoDemoLabel.topAnchor.constraint(equalTo: lineSeparator.bottomAnchor,constant:175).isActive = true
        videoDemoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoDemoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        videoDemoLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-40).isActive = true
        
        let lineSeparator2 = UIView()
        lineSeparator2.backgroundColor = BSB_ORANGE
        lineSeparator2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineSeparator2)
        lineSeparator2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineSeparator2.topAnchor.constraint(equalTo: videoDemoLabel.bottomAnchor,constant:3).isActive = true
        lineSeparator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(videoDemoThumbnail)
        videoDemoThumbnail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoDemoThumbnail.topAnchor.constraint(equalTo: lineSeparator2.bottomAnchor,constant:25).isActive = true
        videoDemoThumbnail.heightAnchor.constraint(equalToConstant: 174).isActive = true
        videoDemoThumbnail.widthAnchor.constraint(equalToConstant: 309).isActive = true
        
        let playButton = UIImageView()
        playButton.image = UIImage(named: "play_button")
        playButton.contentMode = .scaleToFill
        playButton.translatesAutoresizingMaskIntoConstraints = false
        videoDemoThumbnail.addSubview(playButton)
        playButton.rightAnchor.constraint(equalTo: videoDemoThumbnail.rightAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: videoDemoThumbnail.bottomAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(yourScoreLabel)
        yourScoreLabel.topAnchor.constraint(equalTo: videoDemoThumbnail.bottomAnchor,constant:30).isActive = true
        yourScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yourScoreLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        yourScoreLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-40).isActive = true
        
        let lineSeparator3 = UIView()
        lineSeparator3.backgroundColor = BSB_LIGHT_YELLOW
        lineSeparator3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineSeparator3)
        lineSeparator3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineSeparator3.topAnchor.constraint(equalTo: yourScoreLabel.bottomAnchor,constant:3).isActive = true
        lineSeparator3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator3.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(scoreAmount)
        scoreAmount.topAnchor.constraint(equalTo: lineSeparator3.bottomAnchor,constant:10).isActive = true
        scoreAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        scoreAmount.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
}
