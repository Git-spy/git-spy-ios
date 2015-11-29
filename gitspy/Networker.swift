//
//  Networker.swift
//  gitspy
//
//  Created by Joan Romano on 29/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class Networker {
    static let sharedInstance = Networker()
    var session: NSURLSession?
    var token: String? {
        didSet {
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            sessionConfig.HTTPAdditionalHeaders = ["access_token": token!]
            session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        }
    }
    
    private init() {}
}
