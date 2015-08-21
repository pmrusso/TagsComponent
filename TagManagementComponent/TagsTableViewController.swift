//
//  ViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 11/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class TagsTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, TagsDataSourceDelegate {

    @IBOutlet weak var dataSource: TagsDataSource!
    
    
    var parent: MainViewController!
    
    func dataSourceDelegate(data: TagsDataSource, error: NSError?, tags: [Tag]) {
        tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.dataSource.filteredTags = self.dataSource.items.filter({( tag: Tag) -> Bool in
            let stringMatch = tag.tag.rangeOfString(searchText)
            return (stringMatch != nil)
        })
    }
    

    
    func removeCheckmark(tagToRemove: Int){
        dataSource.selectedItems[tagToRemove] = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (dataSource.items.count == 0){
            dataSource.getAllTags();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("override")
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.dataSource.filteredTags.count
        } else {
            return self.dataSource.items.count
        }
    }*/

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.accessoryType != .Checkmark
        {
            cell?.accessoryType = .Checkmark
            parent.selectTag(dataSource.items[indexPath.row], index: indexPath.row)
            dataSource.selectedItems[indexPath.row] = true
        }
    }

}

