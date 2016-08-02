//
//  VFLabel.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/2/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFLabel: UILabel {

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.textAlignment = .Center

    }

}
