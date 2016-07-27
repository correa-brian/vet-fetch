//
//  VFCollectionViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var cellLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let width = frame.size.width
        let height = frame.size.height
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.contentView.addSubview(self.imageView)
        
        self.cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.cellLabel.textColor = .whiteColor()
        self.cellLabel.textAlignment = .Center
        self.contentView.addSubview(self.cellLabel)
        
        let colors = [
            UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1),
            UIColor(red: 255/255, green: 220/255, blue: 204/255, alpha: 1),
            UIColor(red: 255/255, green: 234/255, blue: 204/255, alpha: 1),
            UIColor(red: 240/255, green: 192/255, blue: 206/255, alpha: 1)
        ]
        
        var i = arc4random()
        i = i % UInt32(colors.count)
        let color = colors[Int(i)]
        
        self.imageView.backgroundColor = color
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
}
