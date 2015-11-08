//
//  StatsAPI.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class StatsAPI {
    
    func json(userId: String, repoId: String, completion: (data: NSData) -> Void) {
        let request = NSURLRequest(URL: NSURL(string: "http://desolate-fjord-2415.herokuapp.com/stats?user_id=" + userId + "&repo_id=" + repoId)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response: NSURLResponse?, error) -> Void in
            if let data = data {
                completion(data: data)
            }
        })
        
        task.resume()
    
    }
    
}
