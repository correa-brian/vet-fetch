//
//  VFAccountViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFAccountViewController: VFViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    //MARK: - Properties
    
    var collectionView: UICollectionView!
    var btnsArray = ["Appointments", "Vet", "Insurance", "Learn More"]
    var bottomContainer: UIScrollView!
    var petManagerBtn: UIButton!
    
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
        
        let width = frame.size.width
        let height = frame.size.height-width
        
        self.bottomContainer = UIScrollView(frame: CGRect(x: 0, y: width, width: width, height: height))
        self.bottomContainer.contentSize = CGSize(width: width, height: 0)
        self.bottomContainer.backgroundColor = .whiteColor()
        self.bottomContainer.pagingEnabled = true
        self.bottomContainer.delegate = self
        
        let tableHeader = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height*0.45))
        self.bottomContainer.addSubview(tableHeader)
        
        let padding = CGFloat(15)
        let dimen = CGFloat(height*0.3)
        var x = width*0.25-dimen*0.5
        
        let petSummaryPhoto = UIImageView(frame: CGRect(x: x, y: padding, width: dimen, height: dimen))
        petSummaryPhoto.backgroundColor = UIColor.redColor()
        petSummaryPhoto.layer.borderWidth = 1
        petSummaryPhoto.layer.cornerRadius = dimen*0.5
        petSummaryPhoto.layer.borderColor = UIColor.clearColor().CGColor
        tableHeader.addSubview(petSummaryPhoto)
        
        x = width*0.5
        
        let labelHeight = CGFloat(44)
        var y = petSummaryPhoto.frame.size.height*0.5
        
        let petNameLabel = VFLabel(frame: CGRect(x: x, y: y, width: x, height: labelHeight))
        petNameLabel.text = "Milkshake"
        tableHeader.addSubview(petNameLabel)
        
        y = tableHeader.frame.size.height-0.5
        
        let line = UIView(frame: CGRect(x: 2*padding, y: y, width: width-4*padding, height: 0.5))
        line.backgroundColor = UIColor.blackColor()
        tableHeader.addSubview(line)
        
        y = tableHeader.frame.size.height
        
        let tableBody = UIView(frame: CGRect(x: 0, y: y, width: width, height: height*0.40))
        self.bottomContainer.addSubview(tableBody)
        
        let weightLabels = ["Age", "7", "54", "Weight"]
        
        for i in 0..<weightLabels.count {
            let labelText = weightLabels[i]
            
            if i < 2{
                x = CGFloat(i)*width*0.5
                y = 0
            }
            
            if i == 2 {
                x = width*0.5
                y = height*0.18
            }
            
            if i == 3 {
                x = 0
                y = height*0.18
            }
            
            let label = VFLabel(frame: CGRect(x: x, y: y, width: width*0.5, height: labelHeight))
            label.text = labelText
            tableBody.addSubview(label)
        }
        
        let btnHeight = height*0.15
        
        self.petManagerBtn = UIButton(frame: CGRect(x: 0, y: height, width: width, height: btnHeight))
        self.petManagerBtn.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.petManagerBtn.setTitle("Manage Your Pet", forState: .Normal)
        self.petManagerBtn.addTarget(self, action: #selector(VFAccountViewController.managePet(_:)), forControlEvents: .TouchUpInside)
        self.bottomContainer.addSubview(self.petManagerBtn)
        
        self.collectionView.addSubview(self.bottomContainer)
        view.addSubview(self.collectionView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateButton()
        
        print("AccountVc User - \(VFViewController.currentUser.email)")
        print("AccountVc Pets - \(VFViewController.pets)")
        print("AccountVc Pets - \(VFViewController.pets.count)")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print(" Account Vc - viewWillAppear")
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func animateButton(){
        
        let height = self.bottomContainer.frame.size.height
        let btnHeight = height*0.15
        
        UIView.animateWithDuration(1.50,
                                   delay: 1.0,
                                   usingSpringWithDamping: 1.5,
                                   initialSpringVelocity: 0,
                                   options: .CurveEaseInOut,
                                   animations: {
                                    
                                    let button = self.petManagerBtn
                                    var frame = button.frame
                                    frame.origin.y = height-btnHeight
                                    button.frame = frame
            },
                                   completion: nil)
    }
    
    func managePet(sender: UIButton){
        
        let petVc = VFPetViewController()
        petVc.tabBarItem = UITabBarItem(title: "Pet", image: UIImage(named:"paw_icon.png"), tag: 0)
        
        let apptVc = VFAppointmentViewController()
        apptVc.tabBarItem = UITabBarItem(title: "Medical", image: UIImage(named:"email_icon.png"), tag: 1)
        
        let controllers = [petVc, apptVc]
        let tab = UITabBarController()
        tab.viewControllers = controllers
    
        self.navigationController?.pushViewController(tab, animated: true)
    }
    
    func setAppropriateVc(sender: String){
        switch sender {
            
        case "Appointments":
            let appointmentVc = VFAppointmentViewController()
            self.navigationController?.pushViewController(appointmentVc, animated: true)
            
        case "Vet":
            print("Vet")
            
        case "Insurance":
            print("Insurance")
            
        case "Learn More":
            print("Learn More")
            
        default:
            print("Default")
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
