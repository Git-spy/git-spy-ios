//
//  RepositoryAPI.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class RepositoryAPI {
    
    func json(userId: String, completion: (data: NSData) -> Void) {
        let request = NSURLRequest(URL: NSURL(string: "http://192.168.0.5:8080/repos?user_id=" + userId)!)
        let task = Networker.sharedInstance.session?.dataTaskWithRequest(request, completionHandler: { (data, response: NSURLResponse?, error) -> Void in
            if let data = data {
                completion(data: data)
            }
        })
        
        task?.resume()
    }
    
}
