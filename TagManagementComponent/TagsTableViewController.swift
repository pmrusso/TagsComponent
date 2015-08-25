//
//  ViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 11/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class TagsTableViewController: UITableViewController, UISearchResultsUpdating, TagsDataSourceDelegate {

    @IBOutlet weak var dataSource: TagsDataSource!
    
    
    var parent: MainViewController!
    
    
    func dataSourceDelegate(data: TagsDataSource, error: NSError?, tags: [Tag]) {
        tableView.reloadData()
    }
    
    
    func removeCheckmark(tagToRemove: Tag){
        var tagToUpdate = dataSource.items.filter({( tag: Tag ) -> Bool in
            let stringMatch = tag.tag.rangeOfString(tagToRemove.tag)
            return (stringMatch != nil)
        })
        tagToUpdate.first?.checked = false
        
        if (dataSource.filteredTags.count != 0) {
            self.dataSource.filteredTags.removeAll(keepCapacity: false)
            self.dataSource.filterContentForSearchText(self.dataSource.searchText!)
        }
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if dataSource.filteredTags.count == 0{
            if cell?.accessoryType != .Checkmark
            {
                cell?.accessoryType = .Checkmark
                    parent.selectTag(dataSource.items[indexPath.row], index: indexPath.row)
            dataSource.items[indexPath.row].checked = true
            }
        }
        else {
            if cell?.accessoryType != .Checkmark
            {
                cell?.accessoryType = .Checkmark
                parent.selectTag(dataSource.filteredTags[indexPath.row], index: indexPath.row)
                dataSource.filteredTags[indexPath.row].checked = true
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.dataSource.filteredTags.removeAll(keepCapacity: false)
        self.dataSource.filterContentForSearchText(searchController.searchBar.text)
        self.dataSource.searchText = searchController.searchBar.text
        tableView.reloadData()
    }

}

