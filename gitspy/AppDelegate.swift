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

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let source = options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String
        window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        if source == "com.apple.SafariViewService" {
            authController?.exchangeCodeForAccessToken(withURL: url, success: { (token, raw) -> Void in
                let message = "oauth with safari view controller: retrieved access token: " + token
                print(message)
                let alertController = UIAlertController(title: "☺", message: message, preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
                self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
            })
            return true
        }
        
        
        return false
    }
}

