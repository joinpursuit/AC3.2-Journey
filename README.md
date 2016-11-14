# AC3.2-Journey

Amber's Contribution

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
    

