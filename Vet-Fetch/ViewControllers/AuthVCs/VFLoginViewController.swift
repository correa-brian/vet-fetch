//
//  VFLoginViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFLoginViewController: VFViewController, UITextFieldDelegate {
    
    var textFields = [UITextField]()
    
    override func loadView(){
        
        self.navigationController?.navigationBarHidden = false
        self.edgesForExtendedLayout = .None
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 255/255, green: 220/255, blue: 204/255, alpha: 1)
        
        let dimen = CGFloat(32)
        
        let cancelBtn = UIButton(type: .Custom)
        cancelBtn.frame = CGRect(x: frame.size.width-1.05*dimen, y: 15, width: dimen, height: dimen)
        cancelBtn.setImage(UIImage(named: "cancel_icon.png"), forState: .Normal)
        cancelBtn.addTarget(self, action: #selector(VFViewController.exit), forControlEvents: .TouchUpInside)
        
        view.addSubview(cancelBtn)
        
        let padding = CGFloat(Constants.padding)
        let width = frame.size.width-2*padding
        let height = CGFloat(32)
        var y = CGFloat(Constants.origin_y)
        
        let fieldNames = ["Email", "Password"]
        
        for i in 0..<fieldNames.count {
            
            let fieldName = fieldNames[i]
            let field = VFTextField(frame: CGRect(x: padding, y: y, width: width, height: height))
            field.delegate = self
            field.placeholder = fieldName
            field.textColor = .grayColor()
            
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
            if textField.isFirstResponder() {
                textField.resignFirstResponder()
                break
            }
        }
    }
    
    func userLogin(profileInfo: Dictionary<String, AnyObject>){
        
        print("UserLogin: \(profileInfo)")
        APIManager.postRequest("/account/login", params: profileInfo, completion: { error, response in
            
            print("Response: \(response)")
            
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
            
            if let result = response!["currentUser"] as? Dictionary<String, AnyObject>{
                
                print("Result: \(result)")
                VFViewController.currentUser.populate(result)
                
                KeychainWrapper.defaultKeychainWrapper().setString("\(profileInfo["email"]!)", forKey: "profileEmail")
                KeychainWrapper.defaultKeychainWrapper().setString("\(profileInfo["password"]!)", forKey: "profilePassword")
                KeychainWrapper.defaultKeychainWrapper().setString(VFViewController.currentUser.id!, forKey: "userId")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.postLoggedInNotification(result)
                    self.exit()
                })
            }
        })
    }
    
    //MARK: - TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let index = self.textFields.indexOf(textField)!
        
        if index == self.textFields.count-1 {
            var missingValue = ""
            var profileInfo = Dictionary<String, AnyObject>()
            
            for textField in self.textFields{
                if textField.text?.characters.count == 0 {
                    missingValue = textField.placeholder!
                    break
                }
                
                profileInfo[textField.placeholder!.lowercaseString] = textField.text!
                print("ProfileInfo: \(profileInfo)")
            }
            
            if missingValue.characters.count > 0 {
                let msg = "You forgot your "+missingValue
                let alert = UIAlertController(title: "Missing Value", message: msg, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))

                self.presentViewController(alert, animated: true, completion: nil)
                return true
            }
        
            self.userLogin(profileInfo)
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
