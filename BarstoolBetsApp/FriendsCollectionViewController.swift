//
//  FriendsCollectionViewController.swift
//  BarstoolBetsApp
//
//  Created by Kayla Jensen on 1/9/17.
//  Copyright © 2017 kaylajensencoding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    func setupCollectionView() {
        let screenWidth = view.frame.size.width - 7.5
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0)
        flowLayout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
        flowLayout.minimumInteritemSpacing = 2.5
        flowLayout.minimumLineSpacing = 2.5
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendCollectionViewCell
//        cell.layer.shouldRasterize = true
//        cell.layer.rasterizationScale = UIScreen.main.scale
//        cell.photoImageView.contentMode = .scaleAspectFill
//        cell.photoLabel.text = photo.label
//        cell.photoId = photo.id
//        
//        cell.setNeedsUpdateConstraints()
//        cell.updateConstraintsIfNeeded()
        
        cell.photoLabel.text = "Corbin Jensen"
        cell.photoImageView.image = UIImage(named: "sample")
        cell.photoImageView.focusOnFaces = true
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
