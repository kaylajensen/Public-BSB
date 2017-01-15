//
//  EpicViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/13/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class EpicViewController: UIViewController, UIGestureRecognizerDelegate {

    var player : AVPlayer!
    var playerController : AVPlayerViewController!
    var numPlays = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BSB_LIGHT_YELLOW
        self.navigationController?.navigationBar.isHidden = true
        
        setupWatchEpicBetsView()
        setupEpicView()
    }
    
    func playEpicBets() {
        player.play()
        self.present(playerController, animated: true, completion: nil)
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        
        if numPlays < 1 {
            self.player.seek(to: kCMTimeZero)
            self.player.play()
            numPlays = numPlays + 1
        } else {
            numPlays = 1
            self.tabBarController?.selectedIndex = 1
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK : Setup
extension EpicViewController {
    
    func setupWatchEpicBetsView() {
        let watchLabel = UILabel()
        watchLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        watchLabel.textColor = UIColor.black
        watchLabel.text = "Watch"
        watchLabel.textAlignment = .center
        watchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let betsLabel = UILabel()
        betsLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        betsLabel.textColor = UIColor.black
        betsLabel.text = "Bets"
        betsLabel.textAlignment = .center
        betsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let epicLabel = UIImageView()
        epicLabel.image = UIImage(named: "epic_large_icon")
        epicLabel.translatesAutoresizingMaskIntoConstraints = false
        epicLabel.contentMode = .scaleAspectFit
        
        let playButton = UIImageView()
        playButton.image = UIImage(named: "play_button")
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFit
        
        //190w by 170h
        let container = UIView()
        container.backgroundColor = UIColor.clear
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = true
        
        view.addSubview(container)
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 200).isActive = true
        container.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        container.addSubview(watchLabel)
        watchLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        watchLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        watchLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        watchLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        
        container.addSubview(epicLabel)
        epicLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        epicLabel.topAnchor.constraint(equalTo: watchLabel.bottomAnchor,constant:4).isActive = true
        epicLabel.heightAnchor.constraint(equalToConstant: 85).isActive = true
        epicLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        
        container.addSubview(betsLabel)
        betsLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        betsLabel.topAnchor.constraint(equalTo: epicLabel.bottomAnchor).isActive = true
        betsLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        betsLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        
        container.addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: betsLabel.bottomAnchor,constant:4).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(playEpicBets))
        container.addGestureRecognizer(gesture)
        
    }

    func setupEpicView() {
        let opagueOverlay = UIView()
        opagueOverlay.translatesAutoresizingMaskIntoConstraints = false
        opagueOverlay.layer.cornerRadius = 3
        opagueOverlay.layer.masksToBounds = true
        opagueOverlay.clipsToBounds = false
        opagueOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        
        let epicLogo = UIImageView()
        epicLogo.image = UIImage(named: "epic")
        epicLogo.translatesAutoresizingMaskIntoConstraints = false
        epicLogo.contentMode = .scaleAspectFit
        
        let placeLabel = UILabel()
        placeLabel.text = "Triple C Brewing Company"
        placeLabel.textColor = UIColor.white
        placeLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.textAlignment = .center
        let locationLabel = UILabel()
        locationLabel.text = "Charlotte, NC"
        locationLabel.textColor = UIColor.white
        locationLabel.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .center
        let descriptionLabel = UILabel()
        
        // only allow 100 characters
        descriptionLabel.text = "If I roll a 7... Deer filter with a small child"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        
        let path = Bundle.main.path(forResource: "snippet", ofType: "mov")
        let url = URL(fileURLWithPath: path!)
        
        player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        playerController.view.frame = view.frame
        
        playerController.view.addSubview(epicLogo)
        epicLogo.topAnchor.constraint(equalTo: playerController.view.topAnchor,constant:10).isActive = true
        epicLogo.rightAnchor.constraint(equalTo: playerController.view.rightAnchor,constant:-10).isActive = true
        epicLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        epicLogo.widthAnchor.constraint(equalToConstant: 42).isActive = true
        
        playerController.view.addSubview(opagueOverlay)
        opagueOverlay.centerXAnchor.constraint(equalTo: playerController.view.centerXAnchor).isActive = true
        opagueOverlay.bottomAnchor.constraint(equalTo: playerController.view.bottomAnchor,constant:-10).isActive = true
        opagueOverlay.widthAnchor.constraint(equalTo: playerController.view.widthAnchor,constant:-20).isActive = true
        opagueOverlay.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        opagueOverlay.addSubview(placeLabel)
        placeLabel.topAnchor.constraint(equalTo: opagueOverlay.topAnchor,constant: 5).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        placeLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        opagueOverlay.addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        opagueOverlay.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: opagueOverlay.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: opagueOverlay.widthAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: opagueOverlay.bottomAnchor,constant:-5).isActive = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }

}
