//
//  TagViewModel.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class TagViewModel{
    let tagProper: String
    
    init(tagProper: String){
        self.tagProper = tagProper
    }
    
    convenience init(fullTag: Tag){
        self.init(tagProper: fullTag.tag)
    }
}
