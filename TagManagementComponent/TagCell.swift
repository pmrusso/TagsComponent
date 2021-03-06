//
//  TagCell.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {
    @IBOutlet weak var tagProper: UILabel!
    
    func setupWithViewModel(tagViewModel: TagViewModel){
        self.tagProper?.text = tagViewModel.tagProper
    }
}
