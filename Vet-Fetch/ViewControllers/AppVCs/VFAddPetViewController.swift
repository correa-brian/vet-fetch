//
//  VFAddPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/27/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFAddPetViewController: VFViewController, UITextFieldDelegate {
    
    var textFields = Array<UITextField>()
    
    override func loadView(){
        
        self.navigationController?.navigationBarHidden = false
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 190/255, alpha: 1)
        
        let cancelBtn = UIButton(type: .Custom)
        cancelBtn.frame = CGRect(x: 0, y: 10, width: 32, height: 32)
        cancelBtn.setImage(UIImage(named: "cancel_icon.png"), forState: .Normal)
        cancelBtn.addTarget(
            self,
            action: #selector(VFViewController.exit),
            forControlEvents: .TouchUpInside
        )
        view.addSubview(cancelBtn)
        
        let padding = CGFloat(Constants.padding)
        let width = frame.size.width-2*padding
        let height = CGFloat(32)
        var y = CGFloat(Constants.origin_y)
        
        let fieldNames = ["Name", "Breed", "Sex"]
        
        for i in 0..<fieldNames.count {
            
            let fieldName = fieldNames[i]
            let field = VFTextField(frame: CGRect(x: padding, y: y, width: width, height: height))
            field.delegate = self
            field.placeholder = fieldName
            field.textColor = .whiteColor()
            
            let isPassword = (fieldName == "Password")
            field.secureTextEntry = (isPassword)
            field.returnKeyType = (isPassword) ? .Join : .Next
            
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
            if (textField.isFirstResponder()){
                textField.resignFirstResponder()
                break
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let index = self.textFields.indexOf(textField)!
        
        if(index == self.textFields.count-1){
            var missingValue = ""
            var petInfo = Dictionary<String, AnyObject>()
            
            for textField in self.textFields{
                if(textField.text?.characters.count == 0){
                    missingValue = textField.placeholder!
                    break
                }
                
                petInfo[textField.placeholder!.lowercaseString] = textField.text!
            }
            
            if(missingValue.characters.count > 0){
                print("Missing Value")
                
                let msg = "You forgot your "+missingValue
                let alert = UIAlertController(title: "Missing Value",
                                              message: msg,
                                              preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return true
            }
            
            petInfo["ownerId"] = [VFViewController.currentUser.id!]
            print("Pet Info: \(petInfo)")
        
            APIManager.postRequest("/api/pet",
                                   params: petInfo,
                                   completion: { error, response in
                                    
                                    if (error != nil){
                                        let errorObj = error?.userInfo
                                        
                                        let errorMsg = errorObj!["message"] as! String
                                        print("Error: \(errorMsg)")

                                        dispatch_async(dispatch_get_main_queue(), {
                                            let alert = UIAlertController(
                                                title: "Message",
                                                message: errorMsg,
                                                preferredStyle: .Alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                            self.presentViewController(alert, animated: true, completion: nil)
                                        })

                                        return
                                    }

                                    print("\(response)")
                                    
                                    if let result = response!["result"] as? Dictionary<String, AnyObject>{
                                    
                                        let pet = VFPet()
                                        pet.populate(result)
                                        
                                        dispatch_async(dispatch_get_main_queue(), {
                                            
                                            self.dismissViewControllerAnimated(true, completion: nil)
                                        })
                                    }
            })
            
            return true
        }
        
        let nextField = self.textFields[index+1]
        nextField.becomeFirstResponder()

        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
