//
//  TagsCollectionViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 17/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class TagsCollectionViewController: UICollectionViewController, UICollectionViewDataSource {
    var reuseIdentifier = "SelectedTagCell"
    var selectedTags = [Tag]()
    
    var previousCell: TagCollectionCell!
    
    func selectTag(tagToAdd: Tag){
        self.selectedTags.append(tagToAdd)
        self.selectedTags.sort({$0.tag < $1.tag})
        self.collectionView?.reloadData()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TagCollectionCell
        
        configureCollectionCell(cell, indexPath: indexPath)
        
        self.previousCell = cell
        
        return cell
    }

    
    private func configureCollectionCell(cell: TagCollectionCell, indexPath: NSIndexPath) {
        let tagProper = selectedTags[indexPath.row]
        
        var index = advance(tagProper.color.startIndex, 2)
        let tagColorRed = tagProper.color.substringToIndex(index)
        let tagColorGreen = tagProper.color.substringFromIndex(index).substringToIndex(index)
        var index2 = advance(tagProper.color.startIndex, 4)
        let tagColorBlue = tagProper.color.substringFromIndex(index2).substringToIndex(index)
        
        var r:CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        
        NSScanner(string: tagColorRed).scanHexInt(&r)
        NSScanner(string: tagColorGreen).scanHexInt(&g)
        NSScanner(string: tagColorBlue).scanHexInt(&b)
        
        cell.backgroundColor = UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255 , alpha: CGFloat(1) )
        cell.tagProper.text = tagProper.tag
        cell.tagProper.sizeToFit()
        cell.sizeToFit()
    }
    
}


