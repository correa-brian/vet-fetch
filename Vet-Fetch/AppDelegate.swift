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
    let userIdKey = KeychainWrapper.defaultKeychainWrapper().stringForKey("userId")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if self.userIdKey != nil{
            let accountVc = VFAccountViewController()
            let accountNavCtr = UINavigationController(rootViewController: accountVc)
            self.window?.rootViewController = accountNavCtr
        } else {
            let welcomeVc = VFWelcomeViewController()
            let welcomeNavCtr = UINavigationController(rootViewController: welcomeVc)
            self.window?.rootViewController = welcomeNavCtr
        }
        self.userLogin()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        self.fetchPets()
    }
    
    func userLogin(){
        let retrievedEmail = KeychainWrapper.defaultKeychainWrapper().stringForKey("profileEmail")
        let retrievedPassword = KeychainWrapper.defaultKeychainWrapper().stringForKey("profilePassword")
        
        var profileInfo = Dictionary<String,AnyObject>()
        profileInfo["email"] = retrievedEmail
        profileInfo["password"] = retrievedPassword
        
        APIManager.postRequest("/account/login", params: profileInfo, completion: { error, response in
            if error != nil {
                return
            }
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
    
    func fetchPets(){
        if self.userIdKey == nil {
            return
        }
        var petInfo = Dictionary<String, AnyObject>()
        petInfo["ownerId"] = self.userIdKey
        
        APIManager.getRequest("/api/pet", params: petInfo, completion: { response in
            if let results = response["results"] as? Array<Dictionary<String, AnyObject>>{
                if VFViewController.pets.count != results.count{
                    VFViewController.pets.removeAll()
                    for result in results {
                        let pet = VFPet()
                        pet.populate(result)
                        VFViewController.pets.append(pet)
                    }
                }
            }
        })
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}

