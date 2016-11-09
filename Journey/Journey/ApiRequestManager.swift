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
//  Journey
//
//  Created by Amber Spadafora on 11/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class ApiRequestManager {
    
    static let manager = ApiRequestManager()
    private init() {}
    
    func getData(apiUrl: String, callback: @escaping ((Data?) -> Void)) {
        
        guard let endPointUrl = URL(string: apiUrl) else { return }
        
        let currentUrlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        
        currentUrlSession.dataTask(with: endPointUrl) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
                print("API call was successful")
            }
            }
            .resume()
    }
    
    
    
}




