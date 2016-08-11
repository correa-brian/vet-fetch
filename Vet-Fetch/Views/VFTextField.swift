//
//  VFTextField.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/21/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFTextField: UITextField {

    var icon: UIImageView!
    
    override var placeholder: String? {
        didSet {
            if(placeholder == nil){
                return
            }
            
            if(placeholder?.lowercaseString == "first name"){
                self.icon.image = UIImage(named: "profile_icon.png")
            }
            
            if(placeholder?.lowercaseString == "last name"){
                self.icon.image = UIImage(named: "profile_icon.png")
            }
            
            if(placeholder?.lowercaseString == "email"){
                self.icon.image = UIImage(named: "email_icon.png")
            }
            
            if(placeholder?.lowercaseString == "password"){
                self.icon.image = UIImage(named: "key_icon.png")
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.font = UIFont(name: Constants.baseFont, size: 18)
        self.autocorrectionType = .No
        
        let dimen = frame.size.height
        self.icon = UIImageView(frame: CGRect(x: 0, y: 0, width: dimen, height: dimen))
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: dimen+6, height: dimen))
        iconContainer.addSubview(self.icon)
        
        self.leftViewMode = .Always
        self.leftView = iconContainer
        
        let height = frame.size.height
        let width = frame.size.width
        
        let line = UIView(frame: CGRect(x: iconContainer.frame.size.width, y: height-1, width: width, height: 1))
        line.backgroundColor = .lightGrayColor()
        self.addSubview(line)
    }

}
