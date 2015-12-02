//
//  Parseable.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

protocol Parseable {
    typealias A
    func parse(data: AnyObject) -> A?
}

