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
    var menuCollectionView: UICollectionView!
    var petCollectionView: UICollectionView!
    var petManagerBtn: UIButton!
    
    var pet: VFPet!
    var pets = [VFPet]()
    var btns = ["Account", "Vet", "Insurance", "Learn More"]
    var backgroundImgs = ["dog_running.png", "vet.png", "sunset.png","vet_fetch_logo.png"]
    
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
        loadSamplePets()
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        
        let width = frame.size.width
        let height = frame.size.height-width
        
        let menuCollectionViewLayout = VFCollectionViewFlowLayout()
        self.menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: width), collectionViewLayout: menuCollectionViewLayout)
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.menuCollectionView.registerClass(VFMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        view.addSubview(self.menuCollectionView)
        
        let petCollectionViewLayout = VFHorizontalCollectionViewFlowLayout()
        self.petCollectionView = UICollectionView(frame: CGRect(x: 0, y: self.menuCollectionView.frame.size.height, width: width, height: height), collectionViewLayout: petCollectionViewLayout)
        self.petCollectionView.dataSource = self
        self.petCollectionView.delegate = self
        self.petCollectionView.backgroundColor = .whiteColor()
        self.petCollectionView.registerClass(VFPetCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.petCollectionView.pagingEnabled = true
        view.addSubview(self.petCollectionView)
        
        let btnHeight = height*0.15
        
        self.petManagerBtn = UIButton(frame: CGRect(x: 0, y: frame.size.height, width: width, height: btnHeight))
        self.petManagerBtn.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        self.petManagerBtn.setTitle("Manage Your Pet", forState: .Normal)
        self.petManagerBtn.addTarget(self, action: #selector(VFAccountViewController.managePet(_:)), forControlEvents: .TouchUpInside)
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
    
    override func userLoggedIn(notification: NSNotification){
        super.userLoggedIn(notification)
        self.loadAccountPets()
    }
    
    //MARK: UI Methods
    func animateButton(){
        let frame = UIScreen.mainScreen().bounds
        let height = frame.size.height
        let btnHeight = self.petCollectionView.frame.size.height*0.15
        
        UIView.animateWithDuration(1.50, delay: 1.0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                                    let button = self.petManagerBtn
                                    var frame = button.frame
                                    frame.origin.y = height-btnHeight
                                    button.frame = frame
            },
                                   completion: nil)
    }
    
    func loadSamplePets(){
        let image = UIImage(named: "pencil_icon.png")
        let names = ["Puff", "Tywin", "Vance"]
        let birthdays = ["9/1/10", "2/4/13", "5/28/13"]
        let weight = ["24", "59", "12"]
        let thumbnailUrl = " "
        var samplePets = [VFPet]()
        for i in 0..<3{
            let pet = VFPet()
            pet.name = names[i]
            pet.birthday = birthdays[i]
            pet.weight = weight[i]
            pet.thumbnailData = image
            pet.thumbnailUrl = thumbnailUrl
            samplePets.append(pet)
        }
        self.pets += samplePets
    }
    
    func loadAccountPets(){
        if self.pets.count == 0 {
            return
        }
        self.pets = VFViewController.pets
        dispatch_async(dispatch_get_main_queue(), {
            self.petCollectionView.reloadData()
        })
    }
    
    //MARK: Navigation Methods
    func createPet(btn: UIButton){
        let addPetVc = VFCreatePetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
    }
    
    func managePet(sender: UIButton){
        if self.pets.count == 0{
            let msg = "You haven't add any pets"
            let alert = UIAlertController(title: "No Pets", message: msg, preferredStyle: .Alert)
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
    
    //MARK: CollectionView Delegates
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int!
        if collectionView == self.menuCollectionView{
            count = self.btns.count
        }
        if collectionView == self.petCollectionView{
            count = pets.count
        }
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.menuCollectionView{
            let menuCell = collectionView.dequeueReusableCellWithReuseIdentifier(VFMenuCollectionViewCell.cellId, forIndexPath: indexPath) as! VFMenuCollectionViewCell

            return self.configureMenuCell(menuCell, indexPath: indexPath)
        } else {
            let petCell = collectionView.dequeueReusableCellWithReuseIdentifier(VFPetCollectionViewCell.cellId, forIndexPath: indexPath) as! VFPetCollectionViewCell
    
            return self.configurePetCell(petCell, indexPath: indexPath)
        }
    }
    
    func configureMenuCell(cell: VFMenuCollectionViewCell, indexPath: NSIndexPath) -> VFMenuCollectionViewCell {
        let button = self.btns[indexPath.row]
        let image = self.backgroundImgs[indexPath.row]
        
        cell.cellLabel.text = button
        cell.imageView.image = UIImage(named: image)
        cell.imageView.alpha = 0.75
        return cell
    }
    
    func configurePetCell(cell: VFPetCollectionViewCell, indexPath: NSIndexPath) -> VFPetCollectionViewCell {
        self.pet = self.pets[indexPath.row]
        cell.petNameLabel.text = self.pet.name
        
        let text = ["Birthday", self.pet.birthday, self.pet.weight, "Weight"]
        for i in 0..<text.count{
            cell.petLabelArray[i].text = text[i]
        }
        
        if self.pet.thumbnailUrl.characters.count == 0 {
            return cell
        }
        if self.pet.thumbnailData != nil {
            cell.petImageView.image = pet.thumbnailData
            return cell
        }
        self.pet.fetchThumbnailImage({ image in
            cell.petImageView.image = image
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.menuCollectionView {
            let width = self.menuCollectionView.frame.size.width/2
            return CGSize(width: width, height: width)
        } else {
            let width = self.petCollectionView.frame.size.width
            let height = self.petCollectionView.frame.size.height
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.menuCollectionView{
            let button = self.btns[indexPath.row]
            self.setAppropriateVc(button)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
