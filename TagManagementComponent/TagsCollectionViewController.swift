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
    var parent: MainViewController!
    
    //var previousCell: TagCollectionCell!
    
    func selectTag(tagToAdd: Tag, indexR: Int){
        self.selectedTags.append(tagToAdd)
        self.selectedTags.sort({$0.tag < $1.tag})
        
        
        let index = find(selectedTags, tagToAdd)
        let indexPaths = [NSIndexPath(forRow: index!, inSection: 0)]
        
        collectionView?.insertItemsAtIndexPaths(indexPaths)
        
    }
    
    func deSelectTag(tagToRemove: Tag){
        let index = find(selectedTags, tagToRemove)
        self.selectedTags.removeAtIndex(index!)
        
        let indexPaths = [NSIndexPath(forRow: index!, inSection: 0)]
        
        collectionView?.deleteItemsAtIndexPaths(indexPaths)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let tag = selectedTags[indexPath.row]
        let label = UILabel()
        let labelSize = sizeForText(tag.tag, inLabel: label)
        let crossLabelSize = sizeForText("✕", inLabel: label)
        
        return sizeForTagViewWithLabelSize(labelSize, crossLabelSize: crossLabelSize)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTags.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {        
        parent.removeCheckmark(selectedTags[indexPath.row])
        selectedTags.removeAtIndex(indexPath.row)
        collectionView.deleteItemsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)])
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TagCollectionCell
        
        configureCollectionCell(cell, indexPath: indexPath)
        
        //self.previousCell = cell
        
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
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 6;
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    // MARK: Sizing
    
    private let inset: CGFloat = 16.0
    private let margin: CGFloat = 8.0
    
    func requiredHeightForWidth(width: CGFloat) -> CGFloat {
        var totalLines: CGFloat = 1.0
        var currentLine = inset * 2
        var currentWordsInLine: CGFloat = 0.0
        for tag in selectedTags {
            let viewSize = viewSizeForTag(tag)
            currentLine += viewSize.width + margin
            if (currentLine - margin) > width {
                currentLine = inset * 2 + viewSize.width + margin
                totalLines++
            }
        }
        
        return inset * 2 + totalLines * (viewSizeForTag(selectedTags[0]).height + margin) - margin
    }
    
    private let verticalMargin: CGFloat = 2.0
    
    private func sizeForTagViewWithLabelSize(labelSize: CGSize, crossLabelSize: CGSize) -> CGSize {
        return CGSize(width: ceil(labelSize.width + crossLabelSize.width + margin * 3), height: ceil(labelSize.height + verticalMargin * 2))
    }
    
    private func viewSizeForTag(tag: Tag) -> CGSize {
        let label = UILabel()
        let labelSize = sizeForText(tag.tag, inLabel: label)
        let crossLabelSize = sizeForText("✕", inLabel: label)
        return sizeForTagViewWithLabelSize(labelSize, crossLabelSize: crossLabelSize)
    }
    
    private func sizeForText(text: NSString, inLabel label: UILabel) -> CGSize {
        return text.boundingRectWithSize(CGSize(width: Int.max, height: Int.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil).size
    }

    
}


