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
}

extension Parseable {
    
    init?(data: AnyObject) {
        guard let dictionary = data as? [String: AnyObject] else {
            return nil
        }
        
        self.init(dictionary: dictionary)
    }

}
