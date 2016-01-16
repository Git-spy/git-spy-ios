//
//  User+Network.swift
//  gitspy
//
//  Created by Joan Romano on 29/12/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

extension User {
    
    static func me(token: String, completion: (user: User?) -> Void) {
        let userResource = Resource(pathComponent: "me") { (object) -> User? in
            
            guard let dictionary = object as? [String: AnyObject],
                  let userDictionary = dictionary["user"] as? [String: AnyObject] else {
                    return nil
            }
            
            return User(dictionary: userDictionary)
        }
        
        Networker.sharedInstance.loadResource(userResource, callback: completion)
    }
    
}
