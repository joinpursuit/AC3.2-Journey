//
//  SettingsManager.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/13/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class SettingsManager{
    var distance: Int
    var results: Int
    

    static let manager = SettingsManager()
    private init(){
        self.distance = 5
        self.results = 10
    }
    
    
}
