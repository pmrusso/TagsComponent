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
    
    
    func dataSourceDelegate(data: TagsDataSource, didLoadTags: [Tag]) {
        //tableView.reloadData()
        for tag in didLoadTags {
            dataSource.items.append(tag)
            let index = find(didLoadTags,tag)
            let indexPaths = [NSIndexPath(forRow: index!, inSection: 0)]
            
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func dataSourceDelegate(data: TagsDataSource, didNotLoadTags: NSError?) {
        presentError(didNotLoadTags)
    }
    
    func updateTag(tagToRemove: Tag){
        var tagToUpdate = dataSource.items.filter({( tag: Tag ) -> Bool in
            let stringMatch = tag.tag.rangeOfString(tagToRemove.tag)
            return (stringMatch != nil)
            })
        tagToUpdate.first?.checked = false
    }
    
    func removeCheckmark(tagToRemove: Tag){
        updateTag(tagToRemove)
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
            }else {
                cell?.accessoryType = .None
                dataSource.items[indexPath.row].checked = false
                parent.deSelectTag(dataSource.items[indexPath.row], index: indexPath.row)
            }
        }
        else {
            if cell?.accessoryType != .Checkmark
            {
                cell?.accessoryType = .Checkmark
                parent.selectTag(dataSource.filteredTags[indexPath.row], index: indexPath.row)
                dataSource.filteredTags[indexPath.row].checked = true
            }else {
                cell?.accessoryType = .None
                dataSource.filteredTags[indexPath.row].checked = false
                parent.deSelectTag(dataSource.items[indexPath.row], index: indexPath.row)
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

