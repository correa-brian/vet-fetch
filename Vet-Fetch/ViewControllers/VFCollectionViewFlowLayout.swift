//
//  VFCollectionViewFlowLayout.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        
        let frame = UIScreen.mainScreen().bounds
        
        let dimension = frame.size.width / 2
        self.itemSize = CGSizeMake(dimension, dimension)
        self.minimumInteritemSpacing = 0 //horizontal gape between columns
        self.minimumLineSpacing = 0 //vertical gap between rows
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }

}
