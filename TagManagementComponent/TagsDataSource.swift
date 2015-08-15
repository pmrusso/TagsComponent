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
            self.delegate?.dataSourceDelegate(self, error: nil, tags: self.items)
        }
    }
    
    func configTagCell(cell: TagCell, indexPath: NSIndexPath){
        let tagViewModel = TagViewModel(fullTag: items[indexPath.row])
        cell.setupWithViewModel(tagViewModel)
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath) as! TagCell
            self.configTagCell(cell, indexPath: indexPath)
            return cell
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }

    
}
