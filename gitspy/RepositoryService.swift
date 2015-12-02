//
//  RepositoryService.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class RepositoryService {
    
    let parser: RepositoryParser
    
    init(parser: RepositoryParser = RepositoryParser()) {
        self.parser = parser
    }
    
    func repos(userId: String, completion: (parsedRepos: [Repository]?) -> Void){
        let userResource: Resource<[Repository]> = Resource(pathComponent: "repos?user_id=" + userId, parse: self.parser.parse)
        Networker.sharedInstance.loadResouce(userResource, callback: completion)
    }
    
    func whatch(repoId: Int, completion: (status: Bool?) -> Void) {
        let boolResource: Resource<Bool> = Resource(pathComponent: "repos/" + String(repoId), parse: self.parser.parse, method: "POST")
        Networker.sharedInstance.loadResouce(boolResource, callback: completion)
    }
}
