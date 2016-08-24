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
    static var defaultHeight = CGFloat(96)
    static var padding = CGFloat(12)
    
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    var thumbnail: UIImageView!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        let frame = UIScreen.mainScreen().bounds
        
        var y = CGFloat(12)
        let x = VFMedicalRecordTableViewCell.defaultHeight+VFMedicalRecordTableViewCell.padding
        let width = frame.size.width-VFMedicalRecordTableViewCell.padding-x
        
        self.thumbnail = UIImageView(frame: CGRect(x: frame.size.width-VFMedicalRecordTableViewCell.defaultHeight, y: 0, width: VFMedicalRecordTableViewCell.defaultHeight, height: VFMedicalRecordTableViewCell.defaultHeight))
        self.thumbnail.backgroundColor = UIColor(patternImage: UIImage(named: "pencil_icon.png")!)
        self.contentView.addSubview(self.thumbnail)
        
        let font = Constants.baseUrl
        
        self.dateLabel = UILabel(frame: CGRect(x: 0, y: y, width: width, height: 14))
        self.dateLabel.textAlignment = .Right
        self.dateLabel.font = UIFont(name: font, size: 12)
        self.dateLabel.textColor = .lightGrayColor()
        self.contentView.addSubview(self.dateLabel)
        y += self.dateLabel.frame.size.height+2
        
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: y, width: width, height: 22))
        self.descriptionLabel.font = UIFont(name: font, size: 14)
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = .ByWordWrapping
        self.contentView.addSubview(self.descriptionLabel)
        
        let line = UIView(frame: CGRect(x:0, y: VFMedicalRecordTableViewCell.defaultHeight-1, width: frame.size.width, height: 1))
        line.backgroundColor = .lightGrayColor()
        self.contentView.addSubview(line)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
