//
//  VFMedicalCollectionViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/16/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var imageView: UIImageView!
    var cellLabel: UILabel!
    
    static var cellId = "cellId"
    var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.tableView = UITableView(frame: frame, style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(VFMedicalRecordTableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        
        self.contentView.addSubview(self.tableView)
        
//        let width = frame.size.width
//        let height = frame.size.height
        let white = UIColor.whiteColor()
//
//        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        self.contentView.addSubview(self.imageView)
//        
//        self.cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        self.cellLabel.textColor = UIColor.redColor()
//        self.cellLabel.font = UIFont(name: Constants.baseFont, size: 18)
//        self.cellLabel.textAlignment = .Center
//        self.contentView.addSubview(self.cellLabel)
//        
//        self.imageView.backgroundColor = .blueColor()
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = white.CGColor
        self.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(VFMedicalRecordTableViewCell.cellId, forIndexPath: indexPath) as! VFMedicalRecordTableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}
