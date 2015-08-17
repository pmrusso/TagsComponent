//
//  TagCollectionCell.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 17/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class TagCollectionCell: UICollectionViewCell {
    @IBOutlet weak var tagProper: UILabel!
    
    func setupWithViewModel(tagViewModel: TagViewModel){
        self.tagProper?.text = tagViewModel.tagProper
    }
}
