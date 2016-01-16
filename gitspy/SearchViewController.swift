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
    @IBOutlet private weak var textField: UITextField!
    private var repos: [Repository]?
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange", name: UITextFieldTextDidChangeNotification, object: textField)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("repositoryCell", forIndexPath: indexPath) as! RepositoryCollectionViewCell
        
        guard let repo = repos?[indexPath.item] else {
            return cell
        }
        
        cell.repositoryTitle = repo.name
        cell.selected = repo.watching
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let repoId = repos?[indexPath.item].id else {
            return
        }
        
        Repository.watch(repoId) { status in
            guard let status = status else {
                return
            }
            
            self.repos?[indexPath.item].watching = status
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }
    }
    
    // MARK: UITextFieldDelegate
    
    private let blacklistedCharacters: Set<String> = ["\n"]
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // FIXME: find all charcaters to be excluded
        return !blacklistedCharacters.contains(string)
    }
    
    func textFieldTextDidChange() {
        guard let text = textField.text where text.characters.count > 0 else {
            return
        }
        
        Repository.repos(text){ (parsedRepos) -> Void in
            self.repos = parsedRepos
            self.collectionView.reloadData()
        }
    }
    
}
