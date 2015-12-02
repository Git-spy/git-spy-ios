//
//  RepositoryParser.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class RepositoryParser {
    
    func parse(data: AnyObject) -> [Repository]? {
        var reposArray: [Repository]? = []
        let dictionary = data as! [String: AnyObject]
            
        if let repositories = dictionary["repos"] as? [[String: AnyObject]] {
            for repository in repositories {
                if let description = repository["description"] as? String,
                    name = repository["name"] as? String,
                    language = repository["language"] as? String,
                    id = repository["id"] as? Int,
                    newStars: Int = repository["new_stars"] as? Int,
                    totalStars: Int = repository["total_stars"] as? Int {
                        reposArray?.append(Repository(language: language, name: name, description: description, id: id, newStars: newStars, totalStars: totalStars))
                }
            }
        }
        
        return reposArray
    }
    
    func parse(data: AnyObject) -> Bool? {
        let dictionary = data as! [String: AnyObject]
        
        if let status = dictionary["status"] as? String {
            return status == "ok"
        } else {
            return false
        }
    }
    
}
