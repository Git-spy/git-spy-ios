//
//  Repository.swift
//  gitspy
//
//  Created by Joan Romano on 10/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

struct Repository: Parseable {
    
    let language: String
    let name: String
    let description: String
    let id: Int
    let newStars: Int
    let totalStars: Int
    
    var watching: Bool = false
    
    // MARK: Parseable

    init?(dictionary: [String: AnyObject]) {
        guard let description = dictionary["description"] as? String,
                  name = dictionary["name"] as? String,
                  language = dictionary["language"] as? String,
                  id = dictionary["id"] as? Int,
                  newStars: Int = dictionary["new_stars"] as? Int,
                  totalStars: Int = dictionary["total_stars"] as? Int
            else {
                return nil
        }
        
        self.language = language
        self.name = name
        self.description = description
        self.id = id
        self.newStars = newStars
        self.totalStars = totalStars
    }
}
