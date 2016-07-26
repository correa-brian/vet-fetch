//
//  VFAccountViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/20/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFAccountViewController: VFViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var collectionView: UICollectionView!
    var btnsArray = ["Appointments", "Pets", "Medications", "Bills"]
    var bottomScrollView: UIScrollView!
    
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
        view.backgroundColor = .clearColor()
        
        let collectionViewLayout = VFCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        
        self.collectionView.registerClass(VFCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        
        let w = 4*Int(frame.size.width)
        
        self.bottomScrollView = UIScrollView(frame: CGRect(x: 0, y: frame.size.width, width: frame.size.width, height: frame.size.width))
        self.bottomScrollView.contentSize = CGSize(width: w, height: 0)
        self.bottomScrollView.backgroundColor = .yellowColor()
        self.bottomScrollView.pagingEnabled = true
        self.bottomScrollView.delegate = self
        self.collectionView.addSubview(self.bottomScrollView)
        
        view.addSubview(self.collectionView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    //MARK: - CollectionView Delegates
    
    func configureCell(cell: VFCollectionViewCell, indexPath :NSIndexPath){
        let button = self.btnsArray[indexPath.row]
        
        cell.cellLabel.text = button
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.btnsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellId = "cellId"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! VFCollectionViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let button = self.btnsArray[indexPath.row]
        
        self.setAppropriateVc(button)
    }
    
    func setAppropriateVc(sender: String){
        print("My Sender: \(sender)")
        
        switch sender {
            
        case "Appointments":
            print("setting Appointments")
            let appointmentVc = VFAppointmentViewController()
            self.navigationController?.pushViewController(appointmentVc, animated: true)
            
        case "Pets":
            print("setting Pets")
            let petVc = VFPetViewController()
            self.navigationController?.pushViewController(petVc, animated: true)
            
        case "Medications":
            print("setting Medications")
            let medicationVc = VFMedicationViewController()
            self.navigationController?.pushViewController(medicationVc, animated: true)
            
        case "Bills":
            print("setting Bills")
            let billVc = VFBillViewController()
            self.navigationController?.pushViewController(billVc, animated: true)
            
        default:
            print("default")
        }
    }
    
    //MARK: ScrollView Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.x)")
        let offset = scrollView.contentOffset.x
        
        if (offset == 0){
            self.bottomScrollView.backgroundColor = .yellowColor()
        }
        
        if (offset == self.view.frame.size.width){
            self.bottomScrollView.backgroundColor = .orangeColor()
        }
        
        if (offset == self.view.frame.size.width*2){
            self.bottomScrollView.backgroundColor = .redColor()
        }
        if (offset == self.view.frame.size.width*3){
            self.bottomScrollView.backgroundColor = .blueColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
