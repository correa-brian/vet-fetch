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
        
        let welcomeVc = VFWelcomeViewController()
        let welcomeNavCtr = UINavigationController(rootViewController: welcomeVc)
        self.window?.rootViewController = welcomeNavCtr
        
        self.window?.makeKeyAndVisible()
        self.checkCurrentUser()
        return true
    }
    
    func checkCurrentUser(){
        
        APIManager.checkCurrentUser { response in
            if let currentUserInfo = response["currentUser"] as? Dictionary<String, AnyObject>{
                
                let currentUser = VFProfile()
                currentUser.populate(currentUserInfo)
            
                let notification = NSNotification(
                    name: Constants.kUserLoggedInNotification,
                    object: nil,
                    userInfo: ["user":currentUserInfo]
                )
                
                let notificationCenter = NSNotificationCenter.defaultCenter()
                notificationCenter.postNotification(notification)
                
                self.fetchPets(currentUser.id!)
            }
        }
        
    }
    
    func fetchPets(userId: String){
        
        var petInfo = Dictionary<String, AnyObject>()
        petInfo["ownerId"] = userId

        APIManager.getRequest("/api/pet", params: petInfo, completion: { response in
            
            if let results = response["results"] as? Array<Dictionary<String, AnyObject>>{
                for result in results {
                    let pet = VFPet()
                    pet.populate(result)
                }
                
                let notification = NSNotification(
                    name: Constants.kPetFetchNotification,
                    object: nil,
                    userInfo: ["pets": results]
                )
                
                let notificationCenter = NSNotificationCenter.defaultCenter()
                notificationCenter.postNotification(notification)
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

