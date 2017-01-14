//
//  CreateGroupViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/7/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UIGestureRecognizerDelegate, UINavigationBarDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var reuseIdentifier = "createFriendsCell"
    var tableView : UITableView!
    var collectionView : UICollectionView!
    var selectedNames = [String]()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.text = "Create Group"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var groupNameTextView : UITextField = {
        let field = UITextField()
        field.placeholder = "Group Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.defaultTextAttributes = [NSFontAttributeName : UIFont.init(name: "HelveticaNeue-Thin", size: 17)!]
        field.textColor = UIColor.black
        field.autocapitalizationType = .words
        field.keyboardAppearance = .dark
        return field
    }()
    
    var friendsAddedLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
        label.text = "Friends Added"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gradientSeparator : UIImageView = {
        let view = UIImageView(image: UIImage(named: "gradient_line"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var friendsGradientSeparator : UIImageView = {
        let view = UIImageView(image: UIImage(named: "gradient_line"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var createNewGroup : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        let font = UIFont(name: "HelveticaNeue-Thin", size: 30.0)!
        let color = BSB_RED
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.titleLabel!.font = font
        button.addTarget(self, action: #selector(createGroupPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwipeControl()

        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        createNewGroup.isEnabled = false
        groupNameTextView.delegate = self
        groupNameTextView.addTarget(self, action: #selector(checkIfGroupNameEntered), for: .editingChanged)
        
        setupBasicView()
    }
    
    func checkIfGroupNameEntered() {
        let text = groupNameTextView.text!
        if text.isEmpty {
            createNewGroup.isEnabled = false
        } else {
            if selectedNames.count != 0 {
                createNewGroup.isEnabled = true
            }
        }
    }
    
    func swipeRight(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 2
    }
    
    func swipeLeft(recognizer: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func backButtonPressed(sender : AnyObject) {
        print("backbutton pressed")
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func createGroupPressed(sender : AnyObject) {
        print("create group button pressed")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        groupNameTextView.resignFirstResponder()
    }

}

// MARK : Setup
extension CreateGroupViewController {
    func setupSwipeControl() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(recognizer:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        swipeLeft.delegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(recognizer:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        swipeRight.delegate = self
    }
    
    func setupBasicView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.6).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:20).isActive = true
        
        view.addSubview(createNewGroup)
        createNewGroup.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        createNewGroup.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-20).isActive = true
        createNewGroup.heightAnchor.constraint(equalToConstant: 20).isActive = true
        createNewGroup.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: createNewGroup.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:15).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(groupNameTextView)
        groupNameTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant:25).isActive = true
        groupNameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupNameTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        groupNameTextView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.85).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor.lightGray
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: groupNameTextView.centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: groupNameTextView.bottomAnchor,constant: 4).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(friendsAddedLabel)
        friendsAddedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsAddedLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor,constant:40).isActive = true
        friendsAddedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        friendsAddedLabel.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
        
        view.addSubview(gradientSeparator)
        gradientSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gradientSeparator.topAnchor.constraint(equalTo: friendsAddedLabel.bottomAnchor,constant:4).isActive = true
        gradientSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        gradientSeparator.widthAnchor.constraint(equalTo: groupNameTextView.widthAnchor).isActive = true
        
        let tableViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableView = UITableView(frame: tableViewFrame, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: gradientSeparator.bottomAnchor,constant:8).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(friendsGradientSeparator)
        friendsGradientSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsGradientSeparator.topAnchor.constraint(equalTo: tableView.bottomAnchor,constant:8).isActive = true
        friendsGradientSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        friendsGradientSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let screenWidth = view.frame.size.width - 7.5
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
        flowLayout.minimumInteritemSpacing = 2.5
        flowLayout.minimumLineSpacing = 2.5
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height/2)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: flowLayout)
        collectionView.register(CreateGroupFriendCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: friendsGradientSeparator.bottomAnchor,constant:8).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension CreateGroupViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if selectedNames.count == 0 {
            cell.textLabel?.text = "+ Select friends below to add them to your group"
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        cell.textLabel?.text = selectedNames[indexPath.row]
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedNames.count == 0 {
            return 1
        }
        return selectedNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedNames.count == 0 {
            return 120
        }
        
        return 19
    }
}

// MARK: CollectionView Delegate and DataSource
extension CreateGroupViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateGroupFriendCollectionViewCell
        
        cell.photoLabel.text = names[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.photoImageView.image = UIImage(named: "sample")
        } else {
            cell.photoImageView.image = UIImage(named: "matt")
        }
        
        cell.photoImageView.focusOnFaces = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedName = names[indexPath.row]
        var i = 0
        for s in selectedNames {
            if s == selectedName {
                selectedNames.remove(at: i)
                tableView.reloadData()
                return
            }
            i = i + 1
        }
        
        selectedNames.insert(selectedName, at: 0)
        tableView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        groupNameTextView.resignFirstResponder()
    }
}


