//
//  AppDelegate.swift
//  gitspy
//
//  Created by Joan Romano on 11/10/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authController: GitHubOAuthController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        authController = GitHubOAuthController(clientId: "dd92a69106cd26997822", clientSecret: "676e90124a6e741be269a6ed6407948dc99a250a", redirectUri: "GitSpy://token", scope: "user+notifications+repo");
        let viewController = window?.rootViewController as! LoginViewController
        viewController.authUrl = authController?.authUrl
        
        
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let source = options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String
        window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        if source == "com.apple.SafariViewService" {
            authController?.exchangeCodeForAccessToken(withURL: url,
                failure: { (error) -> Void in
                    print("Error retrieving access token")
                }) { (token) -> Void in                    
                    let service = StatsService()
                    service.stats("joanromano", repoId: "CADRACSwippableCell")
            }
            
            return true
        }
        
        
        return false
    }
}

