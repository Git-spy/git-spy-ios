//
//  StatsService.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class RepositoryService {
    
    let api: RepositoryAPI
    let parser: RepositoryParser
    
    init(api: RepositoryAPI = RepositoryAPI(), parser: RepositoryParser = RepositoryParser()) {
        self.api = api
        self.parser = parser
    }
    
    func stats(userId: String){
        api.json(userId) { (data) -> Void in
            print(self.parser.parse(data)) 
        }
    }
}
