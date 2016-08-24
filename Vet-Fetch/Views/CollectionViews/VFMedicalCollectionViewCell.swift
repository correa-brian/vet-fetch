//
//  VFMedicalCollectionViewCell.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/16/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    static var cellId = "cellId"
    var recordsTable: UITableView!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let height = frame.size.height
        let width = frame.size.width
        let white = UIColor.whiteColor()
        
        self.recordsTable = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height), style: .Plain)
        self.recordsTable.delegate = self
        self.recordsTable.dataSource = self
        self.recordsTable.showsVerticalScrollIndicator = false
        self.recordsTable.registerClass(VFMedicalRecordTableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.contentView.addSubview(self.recordsTable)
        
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = white.CGColor
    }
    
    func checkSection(section: Int) -> Int {
        
        var count: Int!
        
        if section == 0 {
            count = 11
        }
        
        if section == 1 {
            count = 21
        }
        
        if section == 2 {
            count = 5
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tag = tableView.tag
        return self.checkSection(tag)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(VFMedicalRecordTableViewCell.cellId, forIndexPath: indexPath) as! VFMedicalRecordTableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }

}
