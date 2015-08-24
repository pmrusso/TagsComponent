//
//  Tag.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class Tag: NSObject{
    var id: Int
    var tag: String
    var color: String
    var checked: Bool
    
    init(id: Int, tag: String, color: String){
        self.id = id
        self.tag = tag
        self.color = color
        self.checked = false
        super.init()
    }
}