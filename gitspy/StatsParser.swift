//
//  StatsParser.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class StatsParser {
    
    func parse(data: NSData) {
        do {
            let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            print(dictionary)
        } catch {
            print(error)
        }
    }
    
}
