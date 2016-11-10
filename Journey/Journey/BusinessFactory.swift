//
//  Business Factory.swift
//  Journey
//
//  Created by Annie Tung on 11/7/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class BusinessFactory {
    
    // MARK: - Singleton
    static let manager: BusinessFactory = BusinessFactory()
    private init() {}
    
    // MARK: - Data parsing
    func getBusinessData(from data: Data) -> [Business]? {
        
        var business = [Business]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let businessDataCasted = jsonData as? [String:AnyObject],
                let searchResult = businessDataCasted["searchResult"] as? [String:AnyObject],
                let searchListings = searchResult["searchListings"] as? [String:AnyObject],
                let searchListing = searchListings["searchListing"] as? [[String:AnyObject]] else { return nil }
            
            for businessObject in searchListing{
                guard let businessName = businessObject["businessName"] as? String,
                    let rating = businessObject["averageRating"] as? Double,
                    let category = businessObject["categories"] as? String,
                    let latitude = businessObject["latitude"] as? Float,
                    let longitude = businessObject["longitude"] as? Float,
                    let phone = businessObject["phone"] as? String,
                    let hours = businessObject["openHours"] as? String,
                    let slogan = businessObject["slogan"] as? String,
                    let street = businessObject["street"] as? String,
                    let city = businessObject["city"] as? String,
                    let state = businessObject["state"] as? String,
                    let zipcode = businessObject["zip"] as? Int else { return  nil }
                
                business.append(Business(name: businessName, rating: rating, category: category, latitude: latitude, longitude: longitude, phone: phone, hours: hours, slogan: slogan, street: street, city: city, state: state, zipcode: zipcode))
                
                dump(business)
            }
        } catch {
            print("Unknown parsing error encountered: \(error)")
        }
        return business
    }
    
    
}


