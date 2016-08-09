//
//  VFProfile.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFProfile: NSObject {

    var id: String?
    var firstName: String!
    var lastName: String!
    var email: String!
    
    func populate(profileInfo: Dictionary<String, AnyObject>){
        let keys = ["id","firstName","lastName","email"]
        
        for key in keys {
            let value = profileInfo[key]
            self.setValue(value, forKey: key)
        }
    }
}
