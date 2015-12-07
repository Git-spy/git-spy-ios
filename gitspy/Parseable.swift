//
//  Parseable.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

protocol Parseable {
    
    init?(dictionary: [String: AnyObject])
    init?(data: AnyObject)
    
    // there could be a cooler way with Array extension + generics...
    static func array(objects: [[String: AnyObject]]) -> [Self]
}

extension Parseable {
    
    init?(data: AnyObject) {
        guard let dictionary = data as? [String: AnyObject] else {
            return nil
        }
        self.init(dictionary: dictionary)
    }

    static func array(objects: [[String: AnyObject]]) -> [Self] {
        var array = [Self]()
        for dictionary in objects {
            if let object = Self(dictionary: dictionary) {
                array.append(object)
            }
        }
        return array
    }

}
