//
//  VFPetCollectionViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 9/8/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetCollectionViewCell: UICollectionViewCell {
    
    static var cellId = "cellId"
    var petImageView: UIImageView!
    var petNameLabel: UILabel!
    var petLabelArray = [UILabel]()
    var labelText: [String]!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)

        let width = frame.size.width
        let height = frame.size.height
        let white = UIColor.whiteColor()
        
        let padding = CGFloat(15)
        let dimen = CGFloat(height*0.3)
        var x = width*0.25-dimen*0.5
        
        let tableHeader = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height*0.45))
        self.contentView.addSubview(tableHeader)
        
        self.petImageView = UIImageView(frame: CGRect(x: x, y: padding, width: dimen, height: dimen))
        self.petImageView.clipsToBounds = true
        self.petImageView.image = UIImage()
        self.petImageView.layer.cornerRadius = dimen*0.5
        self.petImageView.layer.borderColor = white.CGColor
        self.petImageView.layer.borderWidth = 1
        self.petImageView.backgroundColor = .blueColor()
        tableHeader.addSubview(self.petImageView)
        
        x = width*0.5
        let labelHeight = CGFloat(44)
        var y = petImageView.frame.size.height*0.5
        
        self.petNameLabel = VFLabel(frame: CGRect(x: x, y: y, width: x, height: labelHeight))
        self.petNameLabel.text = "Change Me"
        tableHeader.addSubview(self.petNameLabel)
        y = tableHeader.frame.size.height - 0.5
        
        let line = UIView(frame: CGRect(x: 2*padding, y: y, width: width-4*padding, height: 0.5))
        line.backgroundColor = UIColor.blackColor()
        tableHeader.addSubview(line)
        y = tableHeader.frame.size.height
        
        let tableBody = UIView(frame: CGRect(x: 0, y: y, width: width, height: height*0.40))
        self.contentView.addSubview(tableBody)
        
        self.labelText = ["A","B","C","D"]
        for i in 0..<labelText.count {
            let text = self.labelText[i]
            if i < 2 {
                x = CGFloat(i)*width*0.5
                y = 0
            }
            if i == 2 {
                x = width*0.5
                y = height*0.18
            }
            if i == 3 {
                x = 0
                y = height*0.18
            }
            let label = VFLabel(frame: CGRect(x: x, y: y, width: width*0.5, height: labelHeight))
            label.text = text as String
            self.petLabelArray.append(label)
            tableBody.addSubview(label)
        }
        
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.redColor().CGColor
    }
}
