//
//  apiManager.swift
//  Journey
//
//  Created by Amber Spadafora on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

//
//  APIManager.swift
//  NASAPhotoOfTheDay
//
//  Created by Amber Spadafora on 11/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIManager {
    
    static let manager = APIManager()
    private init() {}
    
    
    let apiEndPointString: String = ""
     let apiEndPoint: URL = URL(string: "")!
    
//    var instagramAPICallString: String = "https://api.instagram.com/v1/media/search?lat=\(businesslat)&lng=\(businesslng)&access_token=ACCESS-TOKEN"
    
    
    
    func getData(callback: @escaping ((Data?) -> Void)) {
        
        let currentUrlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        
        currentUrlSession.dataTask(with: APIManager.manager.apiEndPoint) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
                print("yelp API call was successful")
            }
            }
            .resume()
        
    }
    
    func getIGDataforLat_Long(lat: Float, long: Float, callback: @escaping ((Data?) -> Void)) {
        
        let latString = "\(lat)"
        let longString = "\(long)"
        
        let fullEndPointString = "https://api.instagram.com/v1/media/search?lat=\(latString)&lng=\(longString)&access_token=ACCESS-TOKEN"
        let endPointURL: URL = URL(string: fullEndPointString)!
        
        
        let currentUrlSession = URLSession(configuration: URLSessionConfiguration.default)
        currentUrlSession.dataTask(with: endPointURL) { (data:Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
                print("IG api request with lat & long was successful")
            }
            }
            .resume()
    }
    
    
}




