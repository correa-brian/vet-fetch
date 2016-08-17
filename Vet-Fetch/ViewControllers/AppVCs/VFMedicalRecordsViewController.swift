//
//  VFMedicalRecordsViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/16/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalRecordsViewController: VFViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var btnsArray = Array<UIButton>()
    var collectionView: UICollectionView!
    
    //MARK: - Lifecycle Methods
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
        self.edgesForExtendedLayout = .None
    }
    
    override func loadView(){
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGrayColor()
        
        let width = CGFloat(frame.size.width)
        let height = CGFloat(frame.size.height)
        
        var y = CGFloat((self.navigationController?.navigationBar.frame.height)!)
        
        let titles = ["Medication", "Vaccines", "Allergies"]
        
        for i in 0..<3{
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: 0, y: y, width: width, height: height*0.15)
            btn.backgroundColor = .redColor()
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.yellowColor().CGColor
            btn.setTitle(titles[i], forState: .Normal)
            btn.tintColor = .whiteColor()
            view.addSubview(btn)
            y += btn.frame.size.height
        }
        
        let collectionViewLayout = VFMedicalCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: y, width: width, height: height-y), collectionViewLayout: collectionViewLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(VFMedicalCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.collectionView.pagingEnabled = true
        self.collectionView.backgroundColor = .yellowColor()
        
        view.addSubview(self.collectionView)
        
//        self.optionsTable = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height*0.5), style: .Plain)
//        self.optionsTable.delegate = self
//        self.optionsTable.dataSource = self
//        self.optionsTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
//        
//        view.addSubview(self.optionsTable)
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Height: \(self.collectionView.frame.size.height)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.barTintColor = .clearColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    //MARK: - CollectionView Delegates
    func configureCell(cell: VFMedicalCollectionViewCell, indexPath :NSIndexPath){
        
        let labels = ["Number 1", "Number 2", "Number 3"]
        
        let text = labels[indexPath.row]
        
        cell.cellLabel.text = text
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellId = "cellId"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! VFMedicalCollectionViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"
//        return cell
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
