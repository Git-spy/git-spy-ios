//
//  SearchViewController.swift
//  gitspy
//
//  Created by Joan Romano on 10/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let service = RepositoryService()
    var repos: [Repository]?
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("repositoryCell", forIndexPath: indexPath) as! RepositoryCollectionViewCell
        cell.repositoryTitleLabel.text = repos?[indexPath.item].name
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        service.whatch((repos?[indexPath.item].id)!) { status in
            print(status)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let start = text.startIndex.advancedBy(range.location)
            let end = start.advancedBy(range.length)
            let finalText = text.stringByReplacingCharactersInRange(Range(start: start, end: end), withString: string)
            
            service.repos(finalText){ (parsedRepos) -> Void in
                self.repos = parsedRepos
                self.collectionView.reloadData()
            }
        }
        
        return true
    }
    
}
