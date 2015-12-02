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
    
    let networkerURL = NSURL(string: "http://192.168.0.5:8080/")!
    var session: NSURLSession?
    var token: String? {
        didSet {
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            sessionConfig.HTTPAdditionalHeaders = ["access_token": token!]
            session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        }
    }
    
    func loadResouce<A>(resource: Resource<A>, callback: A? -> ()) {
        var task: NSURLSessionTask?
        let resourceURL = NSURL(string: resource.pathComponent, relativeToURL: networkerURL)!
        let handler: (NSData?, NSURLResponse?, NSError?) -> Void = { data, response, error in
            let json = data.flatMap {try? NSJSONSerialization.JSONObjectWithData($0, options: .AllowFragments)}
            let value = json.flatMap(resource.parse)
            callback(value)
        }

        let request = NSMutableURLRequest(URL: resourceURL)
        request.HTTPMethod = resource.method
        task = session?.dataTaskWithRequest(request, completionHandler: handler)
        
        task?.resume()
    }
    
    private init() {}
}
