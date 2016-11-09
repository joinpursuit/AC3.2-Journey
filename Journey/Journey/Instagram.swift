//
//  Instagram.swift
//  Journey
//
//  Created by Amber Spadafora on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation


class Instagram {
    
    var imageUrlString: String
    var longitude: Float
    var latitude: Float
    
    init(imageUrlString: String, longitude: Float, latitude: Float) {
        self.imageUrlString = imageUrlString
        self.longitude = longitude
        self.latitude = latitude
    }

}
