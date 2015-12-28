//
//  User.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

struct User: Parseable {
    
    let id: Int
    let name: String
 
    // MARK: Parseable
    
    init?(dictionary: [String: AnyObject]) {
        guard let id = dictionary["id"] as? Int, name = dictionary["name"] as? String else {
            return nil
        }

        self.id = id
        self.name = name
    }

}
