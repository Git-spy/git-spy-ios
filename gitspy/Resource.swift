//
//  Resource.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

struct Resource<T> {
    
    let pathComponent: String
    let parse: AnyObject -> T?
    let method: String
    var data: [String: AnyObject]? = nil
    
    init(pathComponent: String, method: String = "GET", parse: AnyObject -> T?) {
        self.pathComponent = pathComponent
        self.method = method
        self.parse = parse
    }
}
