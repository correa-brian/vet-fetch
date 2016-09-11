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
    var btnsArray = ["Account", "Vet", "Insurance", "Learn More"]
    var backgroundImgs = ["dog_running.png", "vet.png", "sunset.png","vet_fetch_logo.png"]
    
    var bottomCollectionView: UICollectionView!
    var petManagerBtn: UIButton!
    
    var pet: VFPet!
    var petsArray = Array<VFPet>()
    
    //MARK: - Lifecycle Methods
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
                                       selector: #selector(VFAccountViewController.loadAccountPets),
                                       name: Constants.kPetFetchNotification,
                                       object: nil)
    }
    
    override func loadView(){
        self.edgesForExtendedLayout = .None
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .redColor()
        
        let width = frame.size.width
        let height = frame.size.height-width
        
        let collectionViewLayout = VFCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: width), collectionViewLayout: collectionViewLayout)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.collectionView.registerClass(VFMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        
        let bottomCollectionViewLayout = VFHorizontalCollectionViewFlowLayout()
        self.bottomCollectionView = UICollectionView(frame: CGRect(x: 0, y: self.collectionView.frame.size.height, width: width, height: height), collectionViewLayout: bottomCollectionViewLayout)
        
        self.bottomCollectionView.dataSource = self
        self.bottomCollectionView.delegate = self
        self.bottomCollectionView.backgroundColor = .whiteColor()
        self.bottomCollectionView.registerClass(VFPetCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.bottomCollectionView.pagingEnabled = true
        
        let btnHeight = height*0.15
        
        self.petManagerBtn = UIButton(frame: CGRect(x: 0, y: frame.size.height, width: width, height: btnHeight))
        self.petManagerBtn.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.petManagerBtn.setTitle("Manage Your Pet", forState: .Normal)
        self.petManagerBtn.addTarget(self, action: #selector(VFAccountViewController.managePet(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(self.collectionView)
        view.addSubview(self.bottomCollectionView)
        view.addSubview(self.petManagerBtn)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadAccountPets()
    }
    
    func loadAccountPets(){
        
        self.petsArray = VFViewController.pets
        
        print("Pets: \(self.petsArray.count)")
        
        if self.petsArray.count == 0 {
            return
        }
        
        self.pet = self.petsArray.reverse()[0]
//        self.petNameLabel.text = self.pet.name
//        
//        let labelText = ["Birthday", self.pet.birthday, self.pet.weight, "Weight"]
//        
//        for i in 0..<self.petLabelArray.count {
//            let text = labelText[i]
//            self.petLabelArray[i].text = text
//        }
//        
//        if self.pet.thumbnailUrl.characters.count == 0 {
//            return
//        }
//        
//        if self.pet.thumbnailData != nil {
//            self.petSummaryPhoto.image = self.pet.thumbnailData
//            return
//        }
//        
//        self.pet.fetchThumbnailImage({ image in
//            self.petSummaryPhoto.image = image
//        })
    }
    
    func animateButton(){

        let frame = UIScreen.mainScreen().bounds
        let height = frame.size.height
        let btnHeight = self.bottomCollectionView.frame.size.height*0.15
        
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
    
    func createPet(btn: UIButton){
        let addPetVc = VFCreatePetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
    }
    
    func managePet(sender: UIButton){
        if self.petsArray.count == 0{
            let msg = "You haven't add any pets"
            let alert = UIAlertController(title: "No Pets",
                                          message: msg,
                                          preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let petVc = VFPetViewController()
        petVc.tabBarItem = UITabBarItem(title: "Pet", image: UIImage(named:"paw_icon.png"), tag: 0)
        petVc.pet = self.pet
        
        let medicalVc = VFMedicalRecordsViewController()
        medicalVc.tabBarItem = UITabBarItem(title: "Medical", image: UIImage(named:"email_icon.png"), tag: 1)
        medicalVc.pet = self.pet
        
        let controllers = [petVc, medicalVc]
        let tab = UITabBarController()
        tab.viewControllers = controllers
    
        self.navigationController?.pushViewController(tab, animated: true)
    }
    
    func setAppropriateVc(sender: String){
        switch sender {
            
        case "Account":
            print("Account")
            
        case "Vet":
            let vetMapVc = VFVetMapViewController()
            self.navigationController?.pushViewController(vetMapVc, animated: true)
            
        case "Insurance":
            print("Insurance")
            
        case "Learn More":
            print("Learn More")
            
        default:
            print("Default")
        }
    }
    
    //MARK: - CollectionView Delegates
    func configureCell(cell: VFMenuCollectionViewCell, indexPath :NSIndexPath){
        let button = self.btnsArray[indexPath.row]
        let image = self.backgroundImgs[indexPath.row]
        
        cell.cellLabel.text = button
        cell.imageView.image = UIImage(named: image)
        cell.imageView.alpha = 0.75
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count: Int!
        
        if collectionView == self.collectionView{
            count = self.btnsArray.count
        }
        
        if collectionView == self.bottomCollectionView{
            print("Set Count")
            count = 3
        }
        
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cellA = collectionView.dequeueReusableCellWithReuseIdentifier(VFMenuCollectionViewCell.cellId, forIndexPath: indexPath) as! VFMenuCollectionViewCell
            
            self.configureCell(cellA, indexPath: indexPath)
            return cellA
        }
        
        else {
            let cellB = collectionView.dequeueReusableCellWithReuseIdentifier(VFPetCollectionViewCell.cellId, forIndexPath: indexPath) as! VFPetCollectionViewCell
            
//            self.configureCell(cellB, indexPath: indexPath)
            return cellB
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if collectionView == self.bottomCollectionView{
            let width = self.bottomCollectionView.frame.size.width
            let height = self.bottomCollectionView.frame.size.height
            
            return CGSize(width: width, height: height)
        }
        
        else{
            let width = self.collectionView.frame.size.width/2
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.collectionView{
            let button = self.btnsArray[indexPath.row]
            self.setAppropriateVc(button)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
