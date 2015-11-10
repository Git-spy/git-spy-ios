//
//  GitHubOAuthController.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

private enum OAuthError: ErrorType {
    case TokenRequest
}

class GitHubOAuthController: OAuth {
    
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
    
    func exchangeCodeForAccessToken(withURL url: NSURL, failure: (error: NSError?) -> Void, success: (token: String) -> Void) {
        do {
            let JSONDataParams = try dataParams(forURL: url)
            let accessTokenRequest: NSURLRequest = request(forJSONData: JSONDataParams)
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
            let task = session.dataTaskWithRequest(accessTokenRequest, completionHandler: { (data, response: NSURLResponse?, error) -> Void in
                do {
                    try self.handleData(data, response: response, error: error, success: success)
                } catch let error as NSError {
                    failure(error: error)
                } catch OAuthError.TokenRequest {
                    failure(error: nil)
                }
            })
            
            task.resume()
        } catch {
            failure(error: nil)
        }
    }
    
    // MARK: Private
    
    private func dataParams(forURL url: NSURL) throws -> NSData {
        let match: String = "?code="
        let range: Range = url.absoluteString.rangeOfString(match)!
        let code = url.absoluteString.substringFromIndex(range.startIndex.advancedBy(match.characters.count))
        let paramDict = ["code" : code,
                         "client_id" : clientId,
                         "client_secret" : clientSecret,
                         "grant_type" : "authorization_code"]
        
        return try NSJSONSerialization.dataWithJSONObject(paramDict as AnyObject, options: .PrettyPrinted)
    }
    
    private func request(forJSONData data: NSData) -> NSURLRequest {
        let url = NSURL(string: "https://github.com/login/oauth/access_token")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(data.length), forHTTPHeaderField: "Content-Length")
        request.HTTPBody = data
        
        return request.copy() as! NSURLRequest
    }
    
    private func handleData(data: NSData?, response: NSURLResponse?, error: NSError?, success: (token: String) -> Void) throws {
        let indexSet = NSIndexSet(indexesInRange: NSRange(location: 200, length: 99));
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode =  httpResponse.statusCode
        
        guard let data = data where indexSet.containsIndex(statusCode) else {
            throw OAuthError.TokenRequest
        }
        
        do {
            let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if let accessToken = dictionary["access_token"] as? String {
                success(token: accessToken)
            } else {
                throw OAuthError.TokenRequest
            }
        } catch {
            throw OAuthError.TokenRequest
        }
    }
}
