//
//  Resource.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

struct Resource<A> {
    let pathComponent: String
    let parse: AnyObject -> A?
    let method: String
    var data: [String: AnyObject]? = nil
    
    init(pathComponent: String, parse: AnyObject -> A?, method: String = "GET") {
        self.pathComponent = pathComponent
        self.parse = parse
        self.method = method
    }
}
