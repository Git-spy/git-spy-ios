//
//  MeParser.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class MeParser: Parseable {
    
    func parse(data: AnyObject) -> User? {
        var user: User?
        let dictionary = data as! [String: AnyObject]
        
        if let userDict = dictionary["user"] as? [String: AnyObject] {
            if let id = userDict["id"] as? Int,
                name = userDict["name"] as? String {
                    user = User(id: id, name: name)
            }
        }
        
        return user
    }
    
}