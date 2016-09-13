//
//  AppDelegate.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/20/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let userIdKey = KeychainWrapper.defaultKeychainWrapper().stringForKey("userId")
        
        if userIdKey != nil{
            print("id retrieved")
            let accountVc = VFAccountViewController()
            let accountNavCtr = UINavigationController(rootViewController: accountVc)
            self.window?.rootViewController = accountNavCtr
        }
            
        else{
            print("id not retrieved")
            let welcomeVc = VFWelcomeViewController()
            let welcomeNavCtr = UINavigationController(rootViewController: welcomeVc)
            self.window?.rootViewController = welcomeNavCtr
        }
        
        self.userLogin()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func userLogin(){
        print("checkCurrentUser")
        
        let retrievedEmail = KeychainWrapper.defaultKeychainWrapper().stringForKey("profileEmail")
        let retrievedPassword = KeychainWrapper.defaultKeychainWrapper().stringForKey("profilePassword")
        
        var profileInfo = Dictionary<String,AnyObject>()
        profileInfo["email"] = retrievedEmail
        profileInfo["password"] = retrievedPassword
        
        APIManager.postRequest("/account/login", params: profileInfo, completion: { error, response in
            
//            if error != nil {
//                let errorObj = error?.userInfo
//                let errorMsg = errorObj!["message"] as! String
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    let alert = UIAlertController(title: "Message", message: errorMsg, preferredStyle: .Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//                    
//                    self.presentViewController(alert, animated: true, completion: nil)
//                })
//                return
//            }

            if let result = response!["currentUser"] as? Dictionary<String, AnyObject>{
                
                let currentUser = VFProfile()
                currentUser.populate(result)
                
                KeychainWrapper.defaultKeychainWrapper().setString(currentUser.id!, forKey: "userId")

                dispatch_async(dispatch_get_main_queue(), {
                    let notification = NSNotification(
                        name: Constants.kUserLoggedInNotification,
                        object: nil,
                        userInfo: ["user":result]
                    )

                    let notificationCenter = NSNotificationCenter.defaultCenter()
                    notificationCenter.postNotification(notification)
                })
            }
        })
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
 
    }

}

