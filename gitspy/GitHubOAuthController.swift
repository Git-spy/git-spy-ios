//
//  GitHubOAuthController.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

class GitHubOAuthController {
    
    private let clientId : String
    private let clientSecret : String
    private let redirectUri : String
    private let scope : String
    
    var authUrl : NSURL? {
        return NSURL(string: "https://github.com/login/oauth/authorize?redirect_uri=" + redirectUri + "&client_id=" + clientId + "&scope=" + scope)
    }
    
    init (clientId : String, clientSecret: String, redirectUri: String, scope: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectUri = redirectUri
        self.scope = scope
    }
    
    func exchangeCodeForAccessToken(withURL url: NSURL, success: (token: String, raw: NSDictionary) -> Void){
        let match: String = "?code="
        let range: Range = url.absoluteString.rangeOfString(match)!
        let code = url.absoluteString.substringFromIndex(range.startIndex.advancedBy(match.characters.count))
        let params = ["code" : code, "client_id" : clientId, "client_secret" : clientSecret, "grant_type" : "authorization_code"]
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(params as AnyObject, options: .PrettyPrinted)
            let theUrl = NSURL(string: "https://github.com/login/oauth/access_token")!
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: theUrl)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(String(jsonData.length), forHTTPHeaderField: "Content-Length")
            request.HTTPBody = jsonData
            
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response: NSURLResponse?, error) -> Void in
                if let data = data {
                    let indexSet = NSIndexSet(indexesInRange: NSRange(location: 200, length: 99));
                    let httpResponse = response as! NSHTTPURLResponse
                    let statusCode =  httpResponse.statusCode
                    if indexSet.containsIndex(statusCode) {
                        do {
                            let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            if let accessToken = dictionary["access_token"] {
                                success(token: accessToken as! String, raw: dictionary)
                            }
                        } catch {
                            
                        }
                    }
                }
            })
            task.resume()
        } catch {
            
        }
    }
}
