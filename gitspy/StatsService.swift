//
//  StatsService.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class StatsService {
    
    let api: StatsAPI
    let parser: StatsParser
    
    init(api: StatsAPI = StatsAPI(), parser: StatsParser = StatsParser()) {
        self.api = api
        self.parser = parser
    }
    
    func stats(userId: String, repoId: String){
        api.json(userId, repoId: repoId) { (data) -> Void in
            self.parser.parse(data)
        }
    }
}
