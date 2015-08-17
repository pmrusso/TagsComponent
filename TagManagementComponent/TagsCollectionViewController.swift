//
//  TagsCollectionViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 17/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class TagsCollectionViewController: UICollectionViewController {
    var reuseIdentifier = "SelectedTagCell"
    var selectedTags = [Tag]()
    
    func selectTag(tagToAdd: Tag){
        self.selectedTags.append(tagToAdd)
        self.collectionView?.reloadData()
    }
}


extension TagsCollectionViewController: UICollectionViewDataSource {
    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
}
