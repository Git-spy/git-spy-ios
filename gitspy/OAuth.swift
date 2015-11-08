//
//  OAuth.swift
//  gitspy
//
//  Created by Joan Romano on 08/11/15.
//  Copyright © 2015 Joan Romano. All rights reserved.
//

import Foundation

protocol OAuth {
    func exchangeCodeForAccessToken(withURL url: NSURL, failure: (error: NSError?) -> Void, success: (token: String) -> Void)
}
