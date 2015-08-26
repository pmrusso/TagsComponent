//
//  TagsDataSource.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//
import UIKit
import CoreData

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
       gateway.getAllTags { tags, err in
        if err == nil {
            self.items = tags!
            self.saveTags()
        }else {
            self.loadTags()
        }
        self.delegate?.dataSourceDelegate(self, error: nil, tags: self.items)
        }
        
    }
    
    func loadTags() {
        var savedTags: [NSManagedObject]
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Tag")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            savedTags = results
            for tag in savedTags {
                let tag = Tag(id: tag.valueForKey("id") as! Int, tag: tag.valueForKey("tag") as! String, color: tag.valueForKey("color") as! String)
                
                self.items.append(tag)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
    }
    
    func saveTags() {
        
        var saveTags: [NSManagedObject]
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Tag",
            inManagedObjectContext:
            managedContext)
        
        for item in self.items {
        
        let tagToSave = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        tagToSave.setValue(item.tag, forKey: "tag")
        tagToSave.setValue(item.id, forKey: "id")
        tagToSave.setValue(item.color, forKey: "color")
        tagToSave.setValue(item.checked, forKey: "checked")
         
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

            
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
