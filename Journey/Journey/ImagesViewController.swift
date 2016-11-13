//
//  ImagesViewController.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/9/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit


class ImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var buiness: Business!
    var instagrams: [Instagram]!
    
    
    @IBOutlet weak var businessDetailsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        
        
        return cell
    }
    
    
    
    func handleNotification(notification: Notification) {
        
        if let accessToken = AccessTokenManager.sharedInstance.accessToken {
            let iGLocationAPIString: String = "https://api.instagram.com/v1/media/search?lat=\(self.buiness.latitude)&lng=\(self.buiness.longitude)&access_token=\(accessToken)"
            print(iGLocationAPIString)
            
            //            if let apiUrl: URL = URL(string: iGLocationAPIString){
            //                print(apiUrl)
            ApiRequestManager.manager.getData(apiUrl: iGLocationAPIString, callback: { (data) in
                guard let validData = data else {
                    print("apiRequest for location data was unsuccessful")
                    return
                }
                self.instagrams = InstagramFactory.manager.getInstagramData(from: validData)!
            })
        }
    }
    
}
