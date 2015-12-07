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
    
    // MARK: Network

    static func repos(userId: String, completion: (parsedRepos: [Repository]?) -> Void) {
        let userResource = Resource(pathComponent: "repos?user_id=" + userId) { (object) -> [Repository]? in
            guard let dictionary = object as? [String: AnyObject],
                let repos = dictionary["repos"] as? [[String: AnyObject]] else {
                return nil
            }
            
            return Repository.array(repos)
        }
        
        Networker.sharedInstance.loadResource(userResource, callback: completion)
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

    init(language: String, name: String, description: String, id: Int, newStars: Int, totalStars: Int) {
        self.language = language
        self.name = name
        self.description = description
        self.id = id
        self.newStars = newStars
        self.totalStars = totalStars
    }
    
    // MARK: Parseable

    init?(dictionary: [String: AnyObject]) {
        guard let description = dictionary["description"] as? String,
            name = dictionary["name"] as? String,
            language = dictionary["language"] as? String,
            id = dictionary["id"] as? Int,
            newStars: Int = dictionary["new_stars"] as? Int,
            totalStars: Int = dictionary["total_stars"] as? Int else {
                return nil
        }
        
        self.init(language: language, name: name, description: description, id: id, newStars: newStars, totalStars: totalStars)
    }

}
