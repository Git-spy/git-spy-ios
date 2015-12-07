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
    
    func setRepository(repository: Repository?) {
        repositoryTitleLabel.text = repository?.name
    }
    
}