//
//  Repository+Network.swift
//  gitspy
//
//  Created by Joan Romano on 29/12/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

extension Repository {
    
    static func repos(userId: String, completion: (parsedRepos: [Repository]?) -> Void) {
        let reposResource = Resource(pathComponent: "repos?user_id=" + userId) { (object) -> [Repository]? in
            guard let dictionary = object as? [String: AnyObject],
                  let repos = dictionary["repos"] as? [[String: AnyObject]]
                else {
                    return nil
            }
            
            return repos.flatMap { Repository(dictionary: $0) }
        }
        
        Networker.sharedInstance.loadResource(reposResource, callback: completion)
    }
    
    static func watch(repoId: Int, completion: (status: Bool?) -> Void) {
        let boolResource = Resource(pathComponent: "repos/" + String(repoId), method: "POST") { (object) -> Bool? in
            guard let status = object["status"] as? String else {
                return nil
            }
            
            return status == "ok"
        }
        
        Networker.sharedInstance.loadResource(boolResource, callback: completion)
    }
    
}
