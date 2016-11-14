# Project: Journey

## Amber's Contribution
### Notification Center

I was responsible for creating an Instagram Factory that would parse instagram data. In order to run an API call based on the businesses location, I needed to first 
receive an access token for the Instagram User, which would then be used for any further Instagram Api calls. I needed to find a way of passing the access token data from the app delegate(where it was created)
to the viewController that would use it. One way of passing data between controllers is using Notification Center and a singleton.

From Apple's documentation 

An NSNotificationCenter object (or simply, notification center) provides a mechanism for broadcasting information within a program. An NSNotificationCenter object is essentially a notification dispatch table.

1. You will need to create a singleton class that will store any variables you would like to use pass along in your project.
  
 For our app, I created a singleton called  AccessTokenManager that had a accessToken property. This property would store the access_token the Instagram API provided, in order for me to use the access_token for different Instagram Endpoints.

2. In the first viewcontroller, after setting the variable of the data you want to pass, add a notificationCenter post and use a unique rawValue string. This rawValue string will be used to send the notifcation to a receiver (i.e where you want to pass your data). This post method of the NSNotificationcenter will send a notice to a reciever, to let the receiver know that the data is available for use. 

example: 

AccessTokenManager.sharedInstance.accessToken = accessTokenString
NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "token")))

3. In the ViewController where you want to pass data, you will need to make that VC an observer, using the same rawValue string you used in the notification post. for selector you will need to add #selector followerd by a function to be called when the observer receives a notice. In the example below I created a handleNotification method. 

example: 
NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name(rawValue: "token"), object: nil)

4. In the viewController that you want to pass the data to you will have to create a method that will handle the notification. 

example: 

      func handleNotification(notification: Notification) {
    }
    Within that function you will want to perform any code that is dependent on the data that has now been passed to the VC.
    
## Annie
### Core Location

During our group project, I learned about Core Location. This framework determines the current latitude and longitude of a device. It uses the available hardware to determine the user’s position and heading. Apps use location data for a variety of purposes ranging from turn by turn navigation to finding local business services, the location data is retrieved through the classes of this framework.

Then we use the classes and protocols in this framework to configure and schedule the delivery of location and heading events. Core Location conforms to a CLLocationManagerDelegate protocol, it defines the methods used to receive location and sends the location data back to the delegate CLLocationManager object. We can also use it to define geographic regions and monitor when the user crosses the boundaries of those regions. In iOS, we can define a region around Bluetooth low-energy beacon regions.

Standard location service: (In this case, we want to load user’s initial location at app launch to display nearby businesses)

In the info.plist you will have to add NSLocationAlwaysUsageDescription and a custom alert message like, ex App needs location service.

import CoreLocation

//Conforms to delegate method

        self.locationManger.delegate = self
        
 //Gets user most accurate location
 
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
//Only use location services when app is in the foreground

        self.locationManger.requestWhenInUseAuthorization()
        
//Starts looking for location

        self.locationManger.startUpdatingLocation()


