//
//  CreateBetViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/17/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class CreateBetViewController: UIViewController {

    var alertContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var betButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "bet_button"), for: .normal)
        button.addTarget(self, action: #selector(createBetButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var ifIRollASevenLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.text = "If I Roll a 7, Corbin has to..."
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    var betTextField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter Bet"
        field.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        field.textColor = UIColor.black
        field.backgroundColor = UIColor.init(netHex: 0xBCBCBC).withAlphaComponent(0.11)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7.5, height: 35))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 7.5, height: 35))
        field.rightViewMode = .always
        return field
    }()
    
    lazy var viewSpecialsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Specials", for: .normal)
        button.setTitleColor(BSB_RED, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        button.addTarget(self, action: #selector(viewSpecialsBetsPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var viewPopularButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Popular", for: .normal)
        button.setTitleColor(BSB_RED, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        button.addTarget(self, action: #selector(viewPopularBetsPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        setupAlertView()
        
        betTextField.becomeFirstResponder()
    }
    
    func viewPopularBetsPressed(sender : AnyObject) {
        print("view popular bets pressed")
    }
    
    func viewSpecialsBetsPressed(sender : AnyObject) {
        print("view specials bets pressed")
    }
    
    func createBetButtonPressed(sender : AnyObject) {
        print("create new bet pressed")
    }
    
    func setupAlertView() {
        view.addSubview(alertContainer)
        alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertContainer.heightAnchor.constraint(equalToConstant:120).isActive = true
        alertContainer.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-45).isActive = true
        
        view.addSubview(betButton)
        betButton.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        betButton.topAnchor.constraint(equalTo: alertContainer.bottomAnchor,constant:-45).isActive = true
        betButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        betButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        alertContainer.addSubview(ifIRollASevenLabel)
        ifIRollASevenLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        ifIRollASevenLabel.topAnchor.constraint(equalTo: alertContainer.topAnchor,constant:10).isActive = true
        ifIRollASevenLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor).isActive = true
        ifIRollASevenLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        alertContainer.addSubview(betTextField)
        betTextField.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        betTextField.topAnchor.constraint(equalTo: ifIRollASevenLabel.bottomAnchor,constant:6).isActive = true
        betTextField.widthAnchor.constraint(equalTo: alertContainer.widthAnchor,constant:-30).isActive = true
        betTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        alertContainer.addSubview(viewSpecialsButton)
        viewSpecialsButton.leftAnchor.constraint(equalTo: alertContainer.leftAnchor).isActive = true
        viewSpecialsButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor).isActive = true
        viewSpecialsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewSpecialsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        alertContainer.addSubview(viewPopularButton)
        viewPopularButton.rightAnchor.constraint(equalTo: alertContainer.rightAnchor).isActive = true
        viewPopularButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor).isActive = true
        viewPopularButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewPopularButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
