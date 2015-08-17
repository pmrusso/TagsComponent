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
    
    func sendMessage(){
        println("Was called")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
            case "TagTableSeg":
                (segue.destinationViewController as! TagsTableViewController).parent = self
                break
            default:
                break
        }
    }
}