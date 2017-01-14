//
//  FriendsCollectionViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/9/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var collectionView: UICollectionView!
    var filterArray : [String] = [String]()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.text = "Friends"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Search Friends"
        bar.barStyle = .default
        
        let txtSearchField : UITextField = bar.value(forKey: "_searchField") as! UITextField
        txtSearchField.backgroundColor = UIColor.white
        txtSearchField.leftViewMode = .never
        txtSearchField.rightViewMode = .never
        txtSearchField.borderStyle = .none
        txtSearchField.font = UIFont.init(name: "HelveticaNeue-Thin", size: 16)
        txtSearchField.layer.cornerRadius = 0
        txtSearchField.layer.borderWidth = 0
        txtSearchField.clearButtonMode = .always
        bar.barTintColor = UIColor.white
        bar.isTranslucent = false
        bar.barTintColor = UIColor.white
        bar.backgroundImage = UIImage()
        bar.backgroundColor = UIColor.white
        bar.autocapitalizationType = .words
        return bar
    }()
    
    var gradientSeparator : UIImageView = {
        let view = UIImageView(image: UIImage(named: "gradient_line"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTopView()
        setupCollectionView()
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func backButtonPressed(sender : AnyObject) {
        print("backbutton pressed")
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupTopView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        view.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:15).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(gradientSeparator)
        gradientSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gradientSeparator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        gradientSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        gradientSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: gradientSeparator.bottomAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
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
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

// MARK: CollectionView Delegate and DataSource
extension FriendsCollectionViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if filterArray.count == 0 {
            return names.count
        } else {
            return filterArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendCollectionViewCell
        
        if filterArray.count == 0 {
            cell.photoLabel.text = names[indexPath.row]
        } else {
            cell.photoLabel.text = filterArray[indexPath.row]
        }
        
        if indexPath.row % 2 == 0 {
            cell.photoImageView.image = UIImage(named: "sample")
        } else {
            cell.photoImageView.image = UIImage(named: "matt")
        }
        cell.photoImageView.focusOnFaces = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(names[indexPath.row]) selected")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText
        filterArray.removeAll()
        for name in names {
            if name.contains(text) {
                filterArray.append(name)
            }
        }
        collectionView.reloadData()
    }
}
