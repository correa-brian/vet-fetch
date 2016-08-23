//
//  VFMedicalRecordTableViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/17/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalRecordTableViewCell: UITableViewCell {
    
    static var cellId = "cellId"
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .greenColor()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
