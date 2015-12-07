//
//  SearchViewController.swift
//  gitspy
//
//  Created by Joan Romano on 10/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var repos: [Repository]?
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("repositoryCell", forIndexPath: indexPath) as! RepositoryCollectionViewCell
        cell.setRepository(repos?[indexPath.item])
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        Repository.watch((repos?[indexPath.item].id)!) { status in
            print(status)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let start = text.startIndex.advancedBy(range.location)
            let end = start.advancedBy(range.length)
            let finalText = text.stringByReplacingCharactersInRange(Range(start: start, end: end), withString: string)
            
            Repository.repos(finalText){ (parsedRepos) -> Void in
                self.repos = parsedRepos
                self.collectionView.reloadData()
            }
        }
        
        return true
    }
    
}
