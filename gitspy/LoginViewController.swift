//
//  ViewController.swift
//  gitspy
//
//  Created by Joan Romano on 11/10/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    var authUrl : NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(sender: UIButton) {
        guard let authUrl = self.authUrl else {
            return
        }
        
        let safariViewController = SFSafariViewController(URL: authUrl, entersReaderIfAvailable: false);
        presentViewController(safariViewController, animated: true, completion: nil)
    }
}

