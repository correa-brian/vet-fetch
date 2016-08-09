//
//  VFLoginViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFLoginViewController: VFViewController, UITextFieldDelegate {
    
    var textFields = Array<UITextField>()
    
    override func loadView(){
        
        self.navigationController?.navigationBarHidden = false
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor(red: 255/255, green: 220/255, blue: 204/255, alpha: 1)
        
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
        
        let fieldNames = ["Email", "Password"]
        
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
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let index = self.textFields.indexOf(textField)!
        
        if(index == self.textFields.count-1){
            var missingValue = ""
            var profileInfo = Dictionary<String, AnyObject>()
            
            for textField in self.textFields{
                if(textField.text?.characters.count == 0){
                    missingValue = textField.placeholder!
                    break
                }
                
                profileInfo[textField.placeholder!.lowercaseString] = textField.text!
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
            
            print("Profile Info: \(profileInfo)")
            
            APIManager.postRequest("/account/login",
                                   params: profileInfo,
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
                                    
                                    if let result = response!["currentUser"] as? Dictionary<String, AnyObject>{
                                        
                                        VFViewController.currentUser.populate(result)
                                        
                                        dispatch_async(dispatch_get_main_queue(), {
                                            
                                            self.postLoggedInNotification(result)
                                            
                                            
                                            let loginVc = VFLoginViewController()
                                            
                                            let nav = UINavigationController(rootViewController: loginVc)
                                            let accountVc = VFAccountViewController()
                                            
                                            nav.pushViewController(accountVc, animated: false)
                                            self.presentViewController(nav, animated: true, completion: nil)
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
