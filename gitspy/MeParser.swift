//
//  MeParser.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class MeParser {
    
    func parse(data: NSData) -> User? {
        var user: User?
        do {
            let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
            
            if let userDict = dictionary["user"] as? [String: AnyObject] {
                if let id = userDict["id"] as? Int,
                       name = userDict["name"] as? String {
                        user = User(id: id, name: name)
                }
            }
            
            return user
        } catch {
            print(error)
            return user
        }
    }
    
}