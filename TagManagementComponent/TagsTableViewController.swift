//
//  ViewController.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 11/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class TagsTableViewController: UITableViewController, TagsDataSourceDelegate {

    @IBOutlet weak var dataSource: TagsDataSource!
    
    func dataSourceDelegate(data: TagsDataSource, error: NSError?, tags: [Tag]) {
        println()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (dataSource.items.count == 0){
            dataSource.gateway.getAllTags({tags in println()})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

