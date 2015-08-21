//
//  TagsDataSource.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//
import UIKit

protocol TagsDataSourceDelegate {
    func dataSourceDelegate(data: TagsDataSource, error: NSError?, tags: [Tag])
}

class TagsDataSource: NSObject, UITableViewDataSource {
    var items = [Tag]()
    var filteredTags = [Tag]()
    var selectedItems = [Bool]()
    var delegate: TagsDataSourceDelegate?
    
    let gateway = TagsGateway()
    
    subscript(index: Int) -> Tag {
        return items[index]
    }
    
    func reset() {
        items = [Tag]()
    }
    
    func getAllTags(){
        gateway.getAllTags { tags in
            self.items = tags
            self.selectedItems = [Bool](count: self.items.count, repeatedValue: false)
            self.delegate?.dataSourceDelegate(self, error: nil, tags: self.items)
        }
    }
    
    func configTagCell(cell: TagCell, indexPath: NSIndexPath){
        let tagViewModel = TagViewModel(fullTag: items[indexPath.row])
        cell.accessoryType = selectedItems[indexPath.row] ? .Checkmark : .None
        cell.setupWithViewModel(tagViewModel)
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath) as! TagCell
            self.configTagCell(cell, indexPath: indexPath)
            return cell
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("not ride")
        return self.items.count;
    }

    
}
