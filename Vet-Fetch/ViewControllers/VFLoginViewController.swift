//
//  VFLoginViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/20/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFLoginViewController: VFViewController, UITextFieldDelegate {
    
    var textFields = Array<UITextField>()
    
    override func loadView(){
        print("loadView Register")
        
        self.navigationController?.navigationBarHidden = false
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        edgesForExtendedLayout = .None
        
        if(self.title == "Login"){
            self.loadLoginView(frame, view: view)
        }
        
        if(self.title == "Register"){
            self.loadRegisterView(frame, view: view)
        }
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loadLoginView(frame: CGRect, view: UIView){
        
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
        
        let btn = UIButton(frame: CGRect(x: padding, y: 300, width: width, height: height))
        btn.setTitle("Click Me", forState: .Normal)
        btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)
        btn.layer.borderColor = UIColor.whiteColor().CGColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 7.5
        btn.titleLabel?.font = UIFont(name: "Arial", size: 16)
        btn.addTarget(self, action: #selector(VFLoginViewController.btnAction(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(btn)
    }
    
    func loadRegisterView(frame: CGRect, view: UIView){
        
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
        
        let fieldNames = ["Email", "Password", "Pet"]
        
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
        
        let btn = UIButton(frame: CGRect(x: padding, y: 300, width: width, height: height))
        btn.setTitle("Click Me", forState: .Normal)
        btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)
        btn.layer.borderColor = UIColor.whiteColor().CGColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 7.5
        btn.titleLabel?.font = UIFont(name: "Arial", size: 16)
        btn.addTarget(self, action: #selector(VFLoginViewController.btnAction(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(btn)
    }
    
    func btnAction(btn: UIButton){
        
        print("btnAction")
        
//        let loginVc = VFLoginViewController()
//        
//        let nav = UINavigationController(rootViewController: loginVc)
//        let b = VFAccountViewController()
//        
//        nav.pushViewController(b, animated: false)
//        self.presentViewController(nav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
