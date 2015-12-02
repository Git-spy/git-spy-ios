//
//  MeService.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class MeService {

    let parser: MeParser
    
    init(parser: MeParser = MeParser()) {
        self.parser = parser
    }
    
    func me(token: String, completion: (parsedUser: User?) -> Void){
        let userResource: Resource<User> = Resource(pathComponent: "me", parse: self.parser.parse)
        Networker.sharedInstance.loadResouce(userResource, callback: completion)
    }
    
}
