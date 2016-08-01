//
//  VFCreatePetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/29/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFCreatePetViewController: VFViewController, UITextFieldDelegate {

    var textFields = Array<UITextField>()
    var petImageView: UIImageView!
    var selectedImage: UIImage?
    var petInfo = Dictionary<String, AnyObject>()
    
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
        
        self.petImageView = UIImageView(frame: CGRect(x: padding, y: y, width: width, height: width))
        self.petImageView.backgroundColor = .blueColor()
        self.petImageView.alpha = 0
        view.addSubview(self.petImageView)
        
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
    
    //MARK: - UIImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.selectedImage = image
        }
        
        picker.dismissViewControllerAnimated(true, completion: {
            
            UIView.transitionWithView(
                self.petImageView,
                duration: 0.3,
                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                animations: {
                    self.petImageView.image = self.selectedImage
                    self.petImageView.alpha = 1.0
                },
                completion: { finished in
                    
                    print("Checking in Completion: \(self.petInfo)")
                    self.createPet(self.petInfo)
            })
        })
    }
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let index = self.textFields.indexOf(textField)!
        
        if(index == self.textFields.count-1){
            var missingValue = ""
            
            for textField in self.textFields{
                if(textField.text?.characters.count == 0){
                    missingValue = textField.placeholder!
                    break
                }
                
                self.petInfo[textField.placeholder!.lowercaseString] = textField.text!
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
            
            self.petInfo["ownerId"] = [VFViewController.currentUser.id!]
            print("Pet Info: \(self.petInfo)")
            
            let alert = UIAlertController(
                title: "Picture",
                message: "Would you like to upload a picture?",
                preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                textField.resignFirstResponder()
                let action = self.showCameraOptions()
                self.presentViewController(action, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
                textField.resignFirstResponder()
                self.createPet(self.petInfo)
                
            }))

            self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        
        let nextField = self.textFields[index+1]
        nextField.becomeFirstResponder()
        
        return true
    }
    
    func createPet(petInfo: Dictionary<String, AnyObject>){
        print("CreatePet")
        
        if(self.selectedImage == nil){
            APIManager.postRequest("/api/pet",
                                   params: self.petInfo,
                                   completion: { error, response in

                                    print("Printing my response: \(response)")

                                    if let result = response!["result"] as? Dictionary<String, AnyObject>{
                                        
                                        print("Result: \(result)")

                                        let pet = VFPet()
                                        pet.populate(result)

                                        dispatch_async(dispatch_get_main_queue(), {
                                            
                                            print("Printing within dispatch")
                                            
//                                            let notificiation = NSNotification(
//                                                name: Constants.kPetCreatedNotification,
//                                                object: nil,
//                                                userInfo: ["pet": pet]
//                                            )
//
//                                            let notificationCenter = NSNotificationCenter.defaultCenter()
//                                            notificationCenter.postNotification(notificiation)
                                            self.dismissViewControllerAnimated(true, completion: nil)
                                        })
                                    }
            })
            
            return
        }
        
        self.uploadImage(selectedImage!, completion: { imageInfo in
            self.selectedImage = nil
            self.petInfo["image"] = imageInfo
            print("Testing Completion Handler: \(self.petInfo)")
            self.createPet(self.petInfo)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
