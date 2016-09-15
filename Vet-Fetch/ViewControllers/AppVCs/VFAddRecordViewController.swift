//
//  VFAddRecordViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/24/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import Alamofire

class VFAddRecordViewController: VFViewController, UITextFieldDelegate {
    
    var pet: VFPet!
    var textFields = [UITextField]()
    var petInfo = Dictionary<String, AnyObject>()

    //MARK: Lifecycle Methods
    override func loadView(){
        self.edgesForExtendedLayout = .None
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 190/255, alpha: 1)
        
        let cancelBtn = UIButton(type: .Custom)
        cancelBtn.frame = CGRect(x: 0, y: 10, width: 32, height: 32)
        cancelBtn.setImage(UIImage(named: "cancel_icon.png"), forState: .Normal)
        cancelBtn.addTarget(self, action: #selector(VFViewController.exit),forControlEvents: .TouchUpInside)
        view.addSubview(cancelBtn)
        
        let padding = CGFloat(Constants.padding)
        let width = frame.size.width-2*padding
        let height = CGFloat(32)
        var y = CGFloat(Constants.origin_y)
        
        let fieldNames = ["Medications", "Vaccines", "Allergies"]
        for i in 0..<fieldNames.count {
            let fieldName = fieldNames[i]
            let field = VFTextField(frame: CGRect(x: padding, y: y, width: width, height: height))
            field.delegate = self
            field.placeholder = fieldName
            field.textColor = .whiteColor()
            
            let isLast = (fieldName == "Allergies")
            field.returnKeyType = (isLast) ? .Done : .Next
            
            view.addSubview(field)
            self.textFields.append(field)
            y += height + padding
        }
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func exit(){
        super.exit()
        for textField in self.textFields {
            if textField.isFirstResponder() {
                textField.resignFirstResponder()
                break
            }
        }
    }
    
    func updatePetRecords(params: Dictionary<String, AnyObject>){
        APIManager.putRequest("/api/pet/"+self.pet!.id!,
                              params: params,
                              completion: { error, response in
                                if error != nil {
                                    let errorObj = error?.userInfo
                                    let errorMsg = errorObj!["message"] as! String
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        let alert = UIAlertController(title: "Message", message: errorMsg, preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                        self.presentViewController(alert, animated: true, completion: nil)
                                        
                                    })
                                    return
                                }
                                
                                if let result = response!["result"] as? Dictionary<String, AnyObject>{
                                    self.fetchPets()
                                    let pet = VFPet()
                                    pet.populate(result)
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.postPetUpdateNotification(result)
                                        self.exit()
                                    })
                                }
        })
    }
    
    func postPetUpdateNotification(updatedPet: Dictionary<String, AnyObject>){
        let notification = NSNotification(
            name: Constants.kPetUpdatedNotification,
            object: nil,
            userInfo: ["pet":updatedPet]
        )
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotification(notification)
    }
    
    //MARK: Textfield Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let index = self.textFields.indexOf(textField)!
        if index == self.textFields.count-1 {
            for textField in self.textFields{
                self.petInfo[textField.placeholder!.lowercaseString] = textField.text?.componentsSeparatedByString(", ")
            }
            self.updatePetRecords(self.petInfo)
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
