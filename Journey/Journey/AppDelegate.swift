//
//  AppDelegate.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
        
        let clientID = "3c1ba9eeaa4d45fa870a0748a63ab7e5"
        let redirectURL = "https://oauth-test-spacedrabbit.herokuapp.com/callback/InstagramTest"
        // https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=code
        let url = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURL)&response_type=code&scope=basic+public_content")!
        
        UIApplication.shared.open(url, options: [:]) { (success: Bool) in
            
        }
 
         */
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("in return")
        
        /* Code for instgram oauth
 
 
 
        var accessCode: String = ""
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let codeParameter = components?.query {
            let stringComponents = codeParameter.components(separatedBy: "=")
            if let code = stringComponents.last {
                accessCode = code
            }
        }
        //  oauth-swift://oauth-callback/InstagramTest?code=49db821efee14dcb9371dd982d72e783
        
        
        let baseURL = URL(string: "https://api.instagram.com/oauth/access_token")!
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        let postData = NSMutableData(data: "client_id=3c1ba9eeaa4d45fa870a0748a63ab7e5".data(using: String.Encoding.utf8)!)
        postData.append("&client_secret=b18d57f39dc048f1ae69e1ef47d1c1f7".data(using: String.Encoding.utf8)!)
        postData.append("&grant_type=authorization_code".data(using: String.Encoding.utf8)!)
        postData.append("&redirect_uri=https://oauth-test-spacedrabbit.herokuapp.com/callback/InstagramTest".data(using: String.Encoding.utf8)!)
        postData.append("&code=\(accessCode)".data(using: String.Encoding.utf8)!)
        
        // todo: figure this out w/o foundation classes
        //    let bodyHTTP: [String.UTF8View : String.UTF8View] = [ "client_id=".utf8 : "f23241255a4847c7a6ec0f81b0c89c42".utf8,
        //                     "&client_secret=".utf8 : "1dca2a33cefa4b74a67e9dfff5646cec".utf8,
        //                     "&grant_type=".utf8 : "authorization_code".utf8,
        //                     "&redirect_uri=".utf8 : "https://oauth-test-spacedrabbit.herokuapp.com/callback/InstagramTest".utf8,
        //                     "&code=".utf8 : accessCode.utf8
        //    ]
        
        //    guard let httpBodyData: Data = try? JSONSerialization.data(withJSONObject: bodyHTTP, options: []) else {
        //      return false
        //    }
        
        urlRequest.httpBody = Data.init(referencing: postData)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: urlRequest, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered: \(error!)")
            }
            
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    
                    guard let unwrappedJson = json else {
                        print("error unwrapping the json")
                        return
                    }
                    
                    print(unwrappedJson)
                    if let accessToken = unwrappedJson["access_token"] {
                        let accessTokenString = accessToken as! String
                        AccessTokenManager.sharedInstance.accessToken = accessTokenString
                        print(accessToken)
                        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "token")))
                        
                    }
                    // access: 10995181.f232412.e238502534ac4d6187ebc85e9527d9f4
                    print("Code retrieved")
                    print(unwrappedJson["access_token"]!)
                }
                catch {
                    print("error parsing json on callback response: \(error)")
                }
                
                
            }
            
        }).resume()
        
 
    */
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
