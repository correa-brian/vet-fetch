//
//  VFMedicalRecordsViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/16/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFMedicalRecordsViewController: VFViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var pet = VFPet()
    var btnsArray = Array<UIButton>()
    var collectionView: UICollectionView!
    
    //MARK: - Lifecycle Methods
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
        self.edgesForExtendedLayout = .None
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: #selector(VFMedicalRecordsViewController.setNewPet(_:)), name: Constants.kPetUpdatedNotification, object: nil)
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
            btn.layer.borderColor = UIColor.greenColor().CGColor
            btn.setTitle(titles[i], forState: .Normal)
            btn.tintColor = .whiteColor()
            btn.addTarget(self, action: #selector(VFMedicalRecordsViewController.moveScroll(_:)), forControlEvents: .TouchUpInside)
            view.addSubview(btn)
            btnsArray.append(btn)
            y += btn.frame.size.height
        }
        
        let collectionViewLayout = VFHorizontalCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: y, width: width, height: height-(y+49)), collectionViewLayout: collectionViewLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(VFMedicalCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.collectionView.pagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(self.collectionView)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.barTintColor = .grayColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addRecord(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = add
    }
    
    func addRecord(btn: UIButton){
        
        let addRecordVc = VFAddRecordViewController()
        addRecordVc.pet = self.pet
        self.navigationController?.presentViewController(addRecordVc, animated: true, completion: nil)
    }
    
    func setNewPet(notification: NSNotification){
        
        if let _pet = notification.userInfo!["pet"] as? Dictionary<String, AnyObject>{
            self.pet.populate(_pet)
            self.collectionView.reloadData()
        }
    }
    
    func moveScroll(btn: UIButton){
        print("moveScroll: \(btn.titleLabel?.text)")
        
        var bool = false
        
        if btn.titleLabel?.text == "Medication"{
            bool = true
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: bool)
        }
        
        if btn.titleLabel?.text == "Vaccines"{
            bool = true
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1), atScrollPosition: .CenteredHorizontally, animated: bool)
        }
        
        if btn.titleLabel?.text == "Allergies"{
            bool = true
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 2), atScrollPosition: .CenteredHorizontally, animated: bool)
        }
        
        if bool == true {
            UIView.animateWithDuration(0.75,
                                       animations: {
                                        
                                        for item in self.btnsArray{
                                            item.backgroundColor = .redColor()
                                        }
                                        
                                        btn.backgroundColor = .purpleColor()
            })
        }
    }
    
    
    //MARK: - CollectionView Delegates
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(VFMedicalCollectionViewCell.cellId, forIndexPath: indexPath) as! VFMedicalCollectionViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = self.collectionView.frame.size.width
        let height = self.collectionView.frame.size.height
    
        return CGSize(width: width, height: height)
    }
    
    func configureCell(cell: VFMedicalCollectionViewCell, indexPath: NSIndexPath){
        
        let section = indexPath.section
        cell.recordsTable.tag = section
        cell.pet = self.pet
        
        dispatch_async(dispatch_get_main_queue(), {
            cell.recordsTable.reloadData()
            
            let lastIndexPath = NSIndexPath(forItem: 0, inSection: 0)
            cell.recordsTable.scrollToRowAtIndexPath(
                lastIndexPath,
                atScrollPosition: .Top,
                animated: true
            )
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
