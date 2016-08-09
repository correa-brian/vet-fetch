//
//  VFCollectionViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
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
        let white = UIColor.whiteColor()
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.contentView.addSubview(self.imageView)
        
        self.cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.cellLabel.textColor = white
        self.cellLabel.font = UIFont(name: Constants.baseFont, size: 18)
        self.cellLabel.textAlignment = .Center
        self.contentView.addSubview(self.cellLabel)
        
        self.imageView.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = white.CGColor
        
    }
}
