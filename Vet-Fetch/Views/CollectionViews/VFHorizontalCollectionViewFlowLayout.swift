//
//  VFHorizontalCollectionViewFlowLayout.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 9/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFHorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollDirection = .Horizontal
    }
}