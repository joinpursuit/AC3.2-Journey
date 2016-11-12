//
//  Instagram Factory.swift
//  Journey
//
//  Created by Amber Spadafora on 11/9/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class InstagramFactory {
    
    static let manager: InstagramFactory = InstagramFactory()
    private init() {}
    
    
    // MARK: - Data Parsing
    
    internal func getInstagramData(from jsonData: Data) -> [Instagram]? {
        
        do {
            let instagramJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let instagramJSONCasted: [String  : AnyObject] = instagramJSONData as? [String : AnyObject],
                let instagramArray: [AnyObject] = instagramJSONCasted["data"] as? [AnyObject] else {
                    return nil
            }
            
            var instagramPhotos: [Instagram] = []
            
            instagramArray.forEach({ instagramObject in
                
                if let instagramPicDictionary: [String : AnyObject] = instagramObject["images"] as? [String : AnyObject],
                    
                    let iGStandardResPicInfo: [String: AnyObject] = instagramPicDictionary["standard_resolution"] as? [String: AnyObject],
                    
                    let iGPicUrlString: String = iGStandardResPicInfo["url"] as? String {
                    
                    instagramPhotos.append(Instagram(imageUrlString: iGPicUrlString))
                    
                }
            })
            
            return instagramPhotos
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
    
}


