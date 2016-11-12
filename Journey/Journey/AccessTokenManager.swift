//
//  AccessTokenManager.swift
//  Journey
//
//  Created by Amber Spadafora on 11/9/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class AccessTokenManager {
    
    static let sharedInstance = AccessTokenManager(accessToken: "abc")
    var accessToken: String?
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    

}

