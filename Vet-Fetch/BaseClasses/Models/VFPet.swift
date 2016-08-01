//
//  VFPet.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/27/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPet: NSObject {

    var id: String?
    var name: String!
    var ownerId: String!
    var sex: String!
    
    var image: Dictionary<String, AnyObject>!
    var imageUrl: String!
    var imageData: String!
    var thumbnailUrl: String!
    var thumbnailData: String!
    var isFetching = false
    
    func populate(petInfo: Dictionary<String,AnyObject>){
        let keys = ["id", "name", "ownerId", "sex"]
        
        for key in keys {
            let value = petInfo[key]
            self.setValue(value, forKey: key)
        }
    }
    
//    func fetchImage(){
//        
//    }
    
    
}
