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

        self.minimumInteritemSpacing = 0 //horizontal gap between columns
        self.minimumLineSpacing = 0 //vertical gap between rows
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollDirection = .Horizontal
    }
}
