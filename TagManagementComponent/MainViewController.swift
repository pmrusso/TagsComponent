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
    
    func selectTag(tagToAdd: Tag) {
        tagCollectionView.selectTag(tagToAdd)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
            case "TagTableSeg":
                (segue.destinationViewController as! TagsTableViewController).parent = self
                break
            case "TagCollectionSeg":
                self.tagCollectionView = segue.destinationViewController as! TagsCollectionViewController
                break
            default:
                break
        }
    }
}