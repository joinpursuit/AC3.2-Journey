//
//  Business Factory.swift
//  Journey
//
//  Created by Annie Tung on 11/7/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class BusinessFactory {
    
//MARK: - Singleton
    static let manager: BusinessFactory = BusinessFactory()
    private init() {}
    
//MARK: - Data parsing
    func getBusinessData(from data: Data) -> [Business]? {
        
        var business = [Business]()
        
        do {
            let businessData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            var categoryArray = [String]()
            
            guard let businessDataCasted = businessData as? [String:AnyObject],
                let businessInfo = businessDataCasted["businesses"] as? [[String:AnyObject]] else { return nil }
            
            businessInfo.forEach({ businessObject in
                guard let name = businessObject["name"] as? String,
                    let location = businessObject["location"] as? [String:AnyObject],
                    let address = location["display_address"] as? [String],
                    let imageURL = businessObject["image_url"] as? String,
                    let starRatingImage = businessObject["rating_img_url_small"] as? String,
                    let coordinate = businessObject["coordinate"] as? [String:AnyObject],
                    let latitude = coordinate["latitude"] as? Float,
                    let longitude = coordinate["longitude"] as? Float,
                    let categories = businessObject["categories"] as? [[String]] else { return }
                
                for category in categories {
                        categoryArray.append(category[0])
                }
                
                business.append(Business(name: name, longitude: longitude, latitude: latitude, category: categoryArray, address: address, starRatingImage: starRatingImage, imageURL: imageURL))
            })
                
        } catch {
            print("Unknown parsing error encountered: \(error)")
        }
        return business
    }
}
//MARK: - API Request Manager
class APIRequestManager {
    
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func makeBusiness(apiPoint: String, callback: @escaping ((Data?) -> Void)) {
        
        guard let url = URL(string: apiPoint) else { return }
        
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error encountered: \(error)")
            }
            
            guard let validData = data else { return }
            callback(validData)
        }
        .resume()
    }
    
}
