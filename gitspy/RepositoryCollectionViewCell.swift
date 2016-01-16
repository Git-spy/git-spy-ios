//
//  RepositoryCollectionViewCell.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var repositoryTitleLabel: UILabel!
    
    var repositoryTitle: String? {
        get {
            return repositoryTitleLabel.text
        }
        set {
            repositoryTitleLabel.text = newValue
        }
    }
    
    override var selected: Bool {
        didSet {
            backgroundColor = selected ? UIColor.grayColor() : UIColor.whiteColor()
        }
    }

}