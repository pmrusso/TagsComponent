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

class TagsDataSource: NSObject, UITableViewDataSource, UISearchBarDelegate {
    var items = [Tag]()
    var filteredTags = [Tag]()
    var delegate: TagsDataSourceDelegate?
    
    let gateway = TagsGateway()
    var searchText : String?
    
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
        
        if (self.searchText?.isEmpty == nil || self.searchText?.isEmpty == true)
        {
            let tagViewModel = TagViewModel(fullTag: items[indexPath.row])
            cell.accessoryType = items[indexPath.row].checked ? .Checkmark : .None
            cell.setupWithViewModel(tagViewModel)
        }else {
            let tagViewModel = TagViewModel(fullTag: filteredTags[indexPath.row])
            cell.accessoryType = filteredTags[indexPath.row].checked ? .Checkmark : .None
            cell.setupWithViewModel(tagViewModel)
        }
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath) as! TagCell
            self.configTagCell(cell, indexPath: indexPath)
            return cell
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchText?.isEmpty == nil || self.searchText?.isEmpty == true ? self.items.count : self.filteredTags.count;
    }

    func filterContentForSearchText(searchText: String) {
        self.filteredTags = self.items.filter({( tag: Tag ) -> Bool in
            let stringMatch = tag.tag.rangeOfString(searchText)
            return (stringMatch != nil)
        })
    }
    
}
