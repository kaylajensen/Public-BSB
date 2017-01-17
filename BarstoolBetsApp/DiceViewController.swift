//
//  DiceViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/17/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController {

    var uprightDiceImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "upright_dice")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var tiltedDiceImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "tilted_dice")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var exitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(exitButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = BSB_RED.withAlphaComponent(0.8)
        
        view.addSubview(uprightDiceImageView)
        uprightDiceImageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        uprightDiceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        uprightDiceImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        uprightDiceImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        view.addSubview(tiltedDiceImageView)
        tiltedDiceImageView.leftAnchor.constraint(equalTo: uprightDiceImageView.rightAnchor).isActive = true
        tiltedDiceImageView.topAnchor.constraint(equalTo: uprightDiceImageView.centerYAnchor).isActive = true
        tiltedDiceImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        tiltedDiceImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        view.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: view.topAnchor,constant:10).isActive = true
        exitButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-10).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func exitButtonPressed(sender : AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
