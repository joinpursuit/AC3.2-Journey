//
//  Business.swift
//  Journey
//
//  Created by Annie Tung on 11/7/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class Business {
    let name: String
    let longitude: Float
    let latitude: Float
    let category: [String]
    let address: [String]
    let starRatingImage: String
    let imageURL: String
    
    init(name: String, longitude: Float, latitude: Float, category: [String], address: [String], starRatingImage: String, imageURL: String) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.category = category
        self.address = address
        self.starRatingImage = starRatingImage
        self.imageURL = imageURL
    }
}

