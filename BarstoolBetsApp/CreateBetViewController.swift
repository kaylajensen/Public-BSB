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
        let viewPopularBetsViewController = PopularBetsViewController()
        viewPopularBetsViewController.modalPresentationStyle = .overCurrentContext
        self.present(viewPopularBetsViewController, animated: false, completion: nil)
    }
    
    func viewSpecialsBetsPressed(sender : AnyObject) {
        print("view specials bets pressed")
        let viewSpecialBetsViewController = SpecialBetsViewController()
        viewSpecialBetsViewController.modalPresentationStyle = .overCurrentContext
        self.present(viewSpecialBetsViewController, animated: false, completion: nil)
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

class PopularBetsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var popularBetsTableView : UITableView!
    
    var alertContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var selectButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "select_button"), for: .normal)
        button.addTarget(self, action: #selector(selectBetButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var popularBetsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.text = "Popular Bets"
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var lineSeparator : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BSB_RED
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        setupAlertView()
    }
    
    func selectBetButtonPressed(sender : AnyObject) {
        print("select bet pressed")
    }
    
    func backButtonPressed(sender : AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupAlertView() {
        view.addSubview(alertContainer)
        alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertContainer.heightAnchor.constraint(equalToConstant:260).isActive = true
        alertContainer.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-45).isActive = true
        
        view.addSubview(selectButton)
        selectButton.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        selectButton.topAnchor.constraint(equalTo: alertContainer.bottomAnchor,constant:-45).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        alertContainer.addSubview(popularBetsLabel)
        popularBetsLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        popularBetsLabel.topAnchor.constraint(equalTo: alertContainer.topAnchor,constant:10).isActive = true
        popularBetsLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor).isActive = true
        popularBetsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        alertContainer.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: popularBetsLabel.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: alertContainer.leftAnchor,constant:5).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        alertContainer.addSubview(lineSeparator)
        lineSeparator.widthAnchor.constraint(equalTo: alertContainer.widthAnchor).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator.topAnchor.constraint(equalTo: popularBetsLabel.bottomAnchor,constant:8).isActive = true
        lineSeparator.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        
        let alertWidth = view.frame.width-55
        let tvFrame = CGRect(x: 0, y: 0, width: alertWidth, height: 170)
        popularBetsTableView = UITableView(frame: tvFrame, style: .plain)
        popularBetsTableView.backgroundColor = UIColor.clear
        popularBetsTableView.separatorStyle = .singleLine
        popularBetsTableView.translatesAutoresizingMaskIntoConstraints = false
        popularBetsTableView.delegate = self
        popularBetsTableView.dataSource = self
        popularBetsTableView.showsVerticalScrollIndicator = false
        popularBetsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        popularBetsTableView.allowsSelection = true
        
        alertContainer.addSubview(popularBetsTableView)
        popularBetsTableView.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        popularBetsTableView.topAnchor.constraint(equalTo: lineSeparator.bottomAnchor,constant:2).isActive = true
        popularBetsTableView.widthAnchor.constraint(equalToConstant: alertWidth).isActive = true
        popularBetsTableView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularBetsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Frantically clean the bar off, and then scream \"WATER!\""
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.imageView?.image = UIImage(named: "wheel")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}

class SpecialBetsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var specialBetsTableView : UITableView!
    
    var alertContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var selectButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "select_button"), for: .normal)
        button.addTarget(self, action: #selector(selectBetButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var specialsBetsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.text = "Specials Near You"
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var lineSeparator : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BSB_RED
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        setupAlertView()
    }
    
    func selectBetButtonPressed(sender : AnyObject) {
        print("select bet pressed")
    }
    
    func backButtonPressed(sender : AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupAlertView() {
        view.addSubview(alertContainer)
        alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertContainer.heightAnchor.constraint(equalToConstant:260).isActive = true
        alertContainer.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-45).isActive = true
        
        view.addSubview(selectButton)
        selectButton.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        selectButton.topAnchor.constraint(equalTo: alertContainer.bottomAnchor,constant:-45).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        alertContainer.addSubview(specialsBetsLabel)
        specialsBetsLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        specialsBetsLabel.topAnchor.constraint(equalTo: alertContainer.topAnchor,constant:10).isActive = true
        specialsBetsLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor).isActive = true
        specialsBetsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        alertContainer.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: specialsBetsLabel.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: alertContainer.leftAnchor,constant:5).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        alertContainer.addSubview(lineSeparator)
        lineSeparator.widthAnchor.constraint(equalTo: alertContainer.widthAnchor).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparator.topAnchor.constraint(equalTo: specialsBetsLabel.bottomAnchor,constant:8).isActive = true
        lineSeparator.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        
        let alertWidth = view.frame.width-55
        let tvFrame = CGRect(x: 0, y: 0, width: alertWidth, height: 170)
        specialBetsTableView = UITableView(frame: tvFrame, style: .plain)
        specialBetsTableView.backgroundColor = UIColor.clear
        specialBetsTableView.separatorStyle = .singleLine
        specialBetsTableView.translatesAutoresizingMaskIntoConstraints = false
        specialBetsTableView.delegate = self
        specialBetsTableView.dataSource = self
        specialBetsTableView.showsVerticalScrollIndicator = false
        specialBetsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        specialBetsTableView.allowsSelection = true
        
        alertContainer.addSubview(specialBetsTableView)
        specialBetsTableView.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor).isActive = true
        specialBetsTableView.topAnchor.constraint(equalTo: lineSeparator.bottomAnchor,constant:2).isActive = true
        specialBetsTableView.widthAnchor.constraint(equalToConstant: alertWidth).isActive = true
        specialBetsTableView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specialBetsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "2 for 1 shots at Rookies"
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.imageView?.image = UIImage(named: "wheel")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}

