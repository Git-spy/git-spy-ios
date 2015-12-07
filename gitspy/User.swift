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
    
    // MARK: Network
    
    static func me(token: String, completion: (user: User?) -> Void) {
        let userResource = Resource(pathComponent: "me") { (object) -> User? in
            // TODO: move this in init?(dictionary)  ??
            guard let dictionary = object as? [String: AnyObject],
                let userDictionary = dictionary["user"] as? [String: AnyObject] else {
                return nil
            }
            
            return User(dictionary: userDictionary)
        }
        
        Networker.sharedInstance.loadResource(userResource, callback: completion)
    }
 
    // MARK: Parseable
    
    init?(dictionary: [String: AnyObject]) {
        guard let id = dictionary["id"] as? Int, name = dictionary["name"] as? String else {
            return nil
        }

        self.id = id
        self.name = name
    }

}
