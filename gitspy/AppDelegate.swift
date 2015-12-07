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
    
    private lazy var authController = GitHubOAuthController(clientId: "dd92a69106cd26997822", clientSecret: "676e90124a6e741be269a6ed6407948dc99a250a", redirectUri: "GitSpy://token", scope: "user+notifications+repo")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        guard let rootViewController = window?.rootViewController as? LoginViewController else {
            assert(false, "rootViewController shouldn't be nil")
        }
        
        rootViewController.authUrl = authController.authUrl
        
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        guard let source = options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String where source == "com.apple.SafariViewService" else {
            return false
        }
        
        window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)

        authController.exchangeCodeForAccessToken(withURL: url,
            failure: { (error) -> Void in
                print("Error retrieving access token")
            }) { (token) -> Void in                    
                Networker.sharedInstance.token = token
                
            User.me(token) { (user) -> Void in
                self.window?.rootViewController?.performSegueWithIdentifier("showSearchRepos", sender: self.window?.rootViewController)
            }
        }
            
        return true
    }
}

