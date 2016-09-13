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
    var pet = VFPet()
    
    var medicationArray = [String]()
    var vaccineArray = [String]()
    var allergyArray = [String]()
    
    var tableArray = [[String]]()
    
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
    
    //MARK: - TableView Delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tag = tableView.tag
        return self.checkSection(tag)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(VFMedicalRecordTableViewCell.cellId, forIndexPath: indexPath) as! VFMedicalRecordTableViewCell
        
        self.congifureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return VFMedicalRecordTableViewCell.defaultHeight
    }
    
    func checkSection(section: Int) -> Int {
        
        var count: Int!
        
        self.tableArray.removeAll()
        
        self.medicationArray = pet.medications
        self.allergyArray = pet.allergies
        self.vaccineArray = pet.vaccines
        
        self.tableArray.append(self.medicationArray)
        self.tableArray.append(self.vaccineArray)
        self.tableArray.append(self.allergyArray)
        
        if section == 0 {
            count = self.medicationArray.count
        }
        
        if section == 1 {
            count = self.vaccineArray.count
        }
        
        if section == 2 {
            count = self.allergyArray.count
        }
        
        return count
    }
    
    func congifureCell(cell: VFMedicalRecordTableViewCell, indexPath: NSIndexPath){
        
        cell.descriptionLabel.text = self.tableArray[self.recordsTable.tag][indexPath.row]
        cell.dateLabel.text = "8/8/16"
    }

}
