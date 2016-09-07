//
//  VFPlace.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 9/6/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import MapKit

class VFPlace: NSObject, MKAnnotation {
    
    var name: String!
    var address = ""
    var rating: Double!
    var lat: Double!
    var lng: Double!
    
    //MARK: - Protocol Method for MK Annotation
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return self.address
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.lat, self.lng)
    }
    
    //MARK: - Parsing Method
    
    func populate(placeInfo: Dictionary<String, AnyObject>) {
        if let _name = placeInfo["name"] as? String {
            self.name = _name
        }
        
        if let _address = placeInfo["vicinity"] as? String {
            self.address = _address
        }
        
        if let _rating = placeInfo["rating"] as? Double {
            self.rating = _rating
        }
        
        if let geometry = placeInfo["geometry"] as? Dictionary<String, AnyObject>{
        
            if let location = geometry["location"] as? Dictionary<String, AnyObject> {
                
                if let _lng = location["lng"] as? Double {
                    self.lng = _lng
                }
                
                if let _lat = location["lat"] as? Double {
                    self.lat = _lat
                }
            }
        }
        
    }

}
