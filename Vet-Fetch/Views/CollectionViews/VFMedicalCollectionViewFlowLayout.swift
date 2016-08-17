//
//  VFMedicalCollectionViewFlowLayout.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/16/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        
        let frame = UIScreen.mainScreen().bounds
    
        let dimension = frame.size.width
        
        self.itemSize = CGSizeMake(dimension, frame.size.height*0.49)
        self.minimumInteritemSpacing = 0 //horizontal gape between columns
        self.minimumLineSpacing = 0 //vertical gap between rows
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollDirection = .Horizontal
    }
}
