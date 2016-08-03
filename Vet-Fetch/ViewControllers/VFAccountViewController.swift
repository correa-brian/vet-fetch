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
    var btnsArray = ["Appointments", "Vet", "Insurance", "Learn More"]
    var bottomScrollView: UIScrollView!
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
        
        self.bottomScrollView = UIScrollView(frame: CGRect(x: 0, y: width, width: width, height: height))
        self.bottomScrollView.contentSize = CGSize(width: width, height: 0)
        self.bottomScrollView.backgroundColor = .whiteColor()
        self.bottomScrollView.pagingEnabled = true
        self.bottomScrollView.delegate = self
        
        let padding = CGFloat(15)
        let dimen = CGFloat(height*0.3)
        var x = width*0.25-dimen*0.5
        
        let petSummaryPhoto = UIImageView(frame: CGRect(x: x, y: padding, width: dimen, height: dimen))
        petSummaryPhoto.backgroundColor = UIColor.redColor()
        petSummaryPhoto.layer.borderWidth = 1
        petSummaryPhoto.layer.cornerRadius = dimen*0.5
        petSummaryPhoto.layer.borderColor = UIColor.clearColor().CGColor
        self.bottomScrollView.addSubview(petSummaryPhoto)
        
        x = width*0.5
        
        let labelHeight = CGFloat(44)
        var y = petSummaryPhoto.frame.size.height*0.5
        
        let petNameLabel = VFLabel(frame: CGRect(x: x, y: y, width: x, height: labelHeight))
        petNameLabel.text = "Milkshake"
        self.bottomScrollView.addSubview(petNameLabel)
        
        y = height*0.45
        
        let line = UIView(frame: CGRect(x: 2*padding, y: y, width: width-4*padding, height: 0.5))
        line.backgroundColor = UIColor.blackColor()
        self.bottomScrollView.addSubview(line)
        
        y = height*0.5
        
        let petWeightLabel = VFLabel(frame: CGRect(x: 0, y: y, width: x, height: labelHeight))
        petWeightLabel.text = "Weight"
        self.bottomScrollView.addSubview(petWeightLabel)
        
        let petWeightText = VFLabel(frame: CGRect(x: x, y: y, width: x, height: labelHeight))
        petWeightText.text = "54"
        self.bottomScrollView.addSubview(petWeightText)
        
        y += height*0.15
        
        let petAgeLabel = VFLabel(frame: CGRect(x: 0, y: y, width: x, height: labelHeight))
        petAgeLabel.text = "Age"
        self.bottomScrollView.addSubview(petAgeLabel)
        
        let petAgeText = VFLabel(frame: CGRect(x: x, y: y, width: x, height: labelHeight))
        petAgeText.text = "5"
        self.bottomScrollView.addSubview(petAgeText)
        
        let btnHeight = height*0.15
        
        self.petManagerBtn = UIButton(frame: CGRect(x: 0, y: height, width: width, height: btnHeight))
        self.petManagerBtn.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.petManagerBtn.setTitle("Manage Your Pet", forState: .Normal)
        self.petManagerBtn.addTarget(self, action: #selector(VFAccountViewController.managePet(_:)), forControlEvents: .TouchUpInside)
        self.bottomScrollView.addSubview(self.petManagerBtn)
        
        self.collectionView.addSubview(self.bottomScrollView)
        view.addSubview(self.collectionView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    func animateButton(){
        
        let height = self.bottomScrollView.frame.size.height
        let btnHeight = height*0.15
        
        UIView.animateWithDuration(1.50,
                                   delay: 1,
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
        self.navigationController?.pushViewController(petVc, animated: true)
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
    
    //MARK: ScrollView Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.x)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
