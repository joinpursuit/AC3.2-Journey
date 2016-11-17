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

During our group project, I learned about Core Location. This framework determines the current latitude and longitude that is associated with the device. It uses the available hardware to determine the user’s position and heading. Apps use location data for a variety of purposes ranging from turn by turn navigation to finding local business services, location data is retrieved through the classes of this framework.

Then we use the classes and protocols in this framework to configure and schedule the delivery of location and heading events. Core Location conforms to a CLLocationManagerDelegate protocol, it defines the methods used to receive location and sends the location data back to the delegate CLLocationManager object. We can also use it to define geographic regions and monitor when the user crosses the boundaries of those regions. In iOS, we can define a region around Bluetooth low-energy beacon regions.

We used a Standard location service: (In our project, we want to load user’s initial location at app launch to display nearby businesses) In the info.plist we added NSLocationAlwaysUsageDescription and a custom alert message, App needs location service, to ask for user's permission.

import CoreLocation

//Conforms to delegate method

        self.locationManger.delegate = self
        
 //Gets user most accurate location
 
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
//Only use location services when app is in the foreground

        self.locationManger.requestWhenInUseAuthorization()
        
//Starts looking for location

        self.locationManger.startUpdatingLocation()
        
I also created the logo, star images and launch screen for our Journey project, hope you like it! Overall, I enjoyed this group project, we not only learn from the experience of others, but everyone learns from seeing other people solution and also having fun at the same time. Sometimes I'd feel like I truly understood some concept - until I had a conversation with someone smarter. That conversation not only helps me realize how little I had understood, but would also leave me richer because of someone else's point of view. I think this is one of the benefits of a group project and group programming, looking forward to the next one! 

## Jermaine's Contribution
I was in charge of the Views, the View Controllers and designing the UI. All though designing a User Interface is not my strong point, I decided to take on this challenge and take my out of my comfort zone. I learnt that building a UI is not a simple as it looks, *(for me at least)* and is something I will do often until I become more comfortable doing it. In this project we decided to have a tableview that displaced the business info and with a search bar in the navigation. After some long thought, the idea came to have each business information displayed on cards, similar to a actually business card. To achieve this, I had to create a custom cell, that had a View and a couple labels to display the business name, address, phone number etc. The View had rounded corners by using `layer.cornerRadius` property and it's shadow with the `layer.shadowOffset` and `layer.shadowOpacity` properties solidified the look I want to achieve.

Another important thing I learnt while working on this project is understanding that how other's approach a problem might be different from mine, and it's important to realize and accept this fact. I was really fun to actually look at other coding styles and see how it all came together to achieve one goal. It was a great learning experience and I look forward to the next one!
