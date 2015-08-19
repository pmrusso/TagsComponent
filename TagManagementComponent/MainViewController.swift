//
//  MainViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 17/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var tagCollectionView: TagsCollectionViewController!
    var tagTableView: TagsTableViewController!
    
    func selectTag(tagToAdd: Tag, index: Int) {
        tagCollectionView.selectTag(tagToAdd, index: index)
    }
    
    func removeCheckmark(tagToRemove: Int){
        tagTableView.removeCheckmark(tagToRemove)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
            case "TagTableSeg":
                self.tagTableView = segue.destinationViewController as! TagsTableViewController
                (segue.destinationViewController as! TagsTableViewController).parent = self
                break
            case "TagCollectionSeg":
                self.tagCollectionView = segue.destinationViewController as! TagsCollectionViewController
                (segue.destinationViewController as! TagsCollectionViewController).parent = self
                break
            default:
                break
        }
    }
}