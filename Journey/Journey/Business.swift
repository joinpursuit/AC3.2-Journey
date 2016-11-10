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
    let rating: Double
    let category: String
    let latitude: Float
    let longitude: Float
    let phone: String
    let hours: String
    let slogan: String
    let street: String
    let city: String
    let state: String
    let zipcode: Int
    
    init(name: String, rating: Double, category: String, latitude: Float, longitude: Float, phone: String, hours: String, slogan: String, street: String, city: String, state: String, zipcode: Int) {
        self.name = name
        self.rating = rating
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.hours = hours
        self.slogan = slogan
        self.street = street
        self.city = city
        self.state = state
        self.zipcode = zipcode
    }
}
