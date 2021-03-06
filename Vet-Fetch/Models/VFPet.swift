//
//  VFPet.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import Alamofire

class VFPet: NSObject {

    var id: String!
    var name: String!
    var ownerId: String!
    var sex: String!
    var breed: String!
    var birthday: String!
    var weight: String!
    var vaccines: [String]!
    var medications: [String]!
    var allergies: [String]!
    
    var image: Dictionary<String, AnyObject>!
    var imageUrl: String!
    var imageData: UIImage?
    var thumbnailUrl: String!
    var thumbnailData: UIImage?
    var isFetching = false

    func populate(petInfo: Dictionary<String,AnyObject>){
        let keys = ["id", "name", "ownerId", "sex", "breed", "birthday", "weight", "vaccines", "allergies", "medications"]
        for key in keys {
            let value = petInfo[key]
            self.setValue(value, forKey: key)
        }
        if let _image = petInfo["image"] as? Dictionary<String, AnyObject>{
            if let _original = _image["original"] as? String {
                self.imageUrl = _original
            }
            if let _thumb = _image["thumb"] as? String {
                self.thumbnailUrl = _thumb
            }
        }
    }

    //MARK: Fetch Image Methods
    func fetchOriginalImage(completion:((image: UIImage) -> Void)?){
        if self.imageUrl.characters.count == 0 {
            return
        }
        if self.imageData != nil {
            return
        }
        if self.isFetching == true {
            return
        }
        self.isFetching = true
        
        Alamofire.request(.GET, self.imageUrl, parameters: nil).response { (req, res, data, error) in
            self.isFetching = false
            if error != nil {
                return
            }
            if let img = UIImage(data: data!){
                self.imageData = img
                if completion != nil {
                    completion!(image: img)
                }
            }
        }
    }
    
    func fetchThumbnailImage(completion:((image: UIImage) -> Void)?){
        if self.thumbnailUrl.characters.count == 0 {
            return
        }
        if self.thumbnailData != nil {
            return
        }
        if self.isFetching == true {
            return
        }
        self.isFetching = true
        
        Alamofire.request(.GET, self.thumbnailUrl, parameters: nil).response { (req, res, data, error) in
            self.isFetching = false
            if error != nil {
                return
            }
            
            if let img = UIImage(data: data!){
                self.thumbnailData = img
                if completion != nil {
                    completion!(image: img)
                }
            }
        }
    }
}
