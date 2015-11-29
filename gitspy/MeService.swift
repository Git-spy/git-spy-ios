//
//  MeService.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class MeService {

    let api: MeAPI
    let parser: MeParser
    
    init(api: MeAPI = MeAPI(), parser: MeParser = MeParser()) {
        self.api = api
        self.parser = parser
    }
    
    func me(token: String, completion: (parsedUser: User?) -> Void){
        api.json(token) { (data) -> Void in
            completion(parsedUser: self.parser.parse(data))
        }
    }
    
}
