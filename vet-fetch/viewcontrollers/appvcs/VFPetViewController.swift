//
//  VFPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetViewController: VFViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var petImage: UIImageView!
    var petNameLabel: UILabel!
    
    var petsArray = Array<VFPet>()
    
    var scrollView: UIScrollView!
    var navScroll: UIScrollView!
    var pageLabel: UILabel!
    var petStats: UITableView!
    var petMedication: UITableView!
    var petVaccination: UITableView!
    
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
        view.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 190/255, alpha: 1)
        
        self.petImage = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.width))
        self.petImage.image = UIImage(named: "account_background.png")
        self.petImage.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 204/255, alpha: 1)
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
        
        let blk = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        layer.colors = [blk.CGColor, UIColor.clearColor().CGColor]
        self.petImage.layer.addSublayer(layer)
        view.addSubview(self.petImage)
        
        self.scrollView = UIScrollView(frame: frame)
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.backgroundColor = .clearColor()
        let bgText = UIView(frame: CGRect(x: 0, y: 250, width: frame.size.width, height: frame.size.height))
        bgText.backgroundColor = .orangeColor()
        
        let padding = CGFloat(10)
        let width = frame.size.width-2*padding
        
        let barView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 72.5))
        barView.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        
        self.pageLabel = UILabel(frame: CGRect(x: padding, y: padding, width: width, height: 24))
        self.pageLabel.textColor = .darkGrayColor()
        self.pageLabel.font = UIFont.boldSystemFontOfSize(20)
        self.pageLabel.text = "General Information"
        barView.addSubview(self.pageLabel)
        
        let font = UIFont(name: "Arial", size: 14)
        var y = padding+pageLabel.frame.size.height
        let lblUsername = UILabel(frame: CGRect(x: padding, y: y, width: width, height: 18))
        lblUsername.textColor = .darkGrayColor()
        lblUsername.font = font
        lblUsername.text = "Hi \(VFViewController.currentUser.firstName)"
        barView.addSubview(lblUsername)
        y += lblUsername.frame.size.height
        
        let x = frame.size.width-88
        
        let addPetBtn = UIButton(type: .Custom)
        addPetBtn.frame = CGRect(x: x, y: padding, width: 44, height: 44)
        addPetBtn.backgroundColor = UIColor.redColor()
        addPetBtn.addTarget(self, action: #selector(VFPetViewController.createPet(_:)), forControlEvents: .TouchUpInside)
        barView.addSubview(addPetBtn)
        
        let line = UIView(frame: CGRect(x: 0, y: barView.frame.size.height-0.5, width: frame.size.width, height: 0.5))
        line.backgroundColor = .lightGrayColor()
        barView.addSubview(line)
        bgText.addSubview(barView)
        
        y = barView.frame.size.height
        
        let scrollWidth = CGFloat(frame.size.width)*3
        
        self.navScroll = UIScrollView(frame: CGRect(x: 0, y: y, width: frame.size.width, height: frame.size.height-y))
        self.navScroll.contentSize = CGSize(width: scrollWidth, height: 0)
        self.navScroll.backgroundColor = .yellowColor()
        self.navScroll.pagingEnabled = true
        self.navScroll.delegate = self
        
        let screenWidth = Int(navScroll.frame.size.width)
        let screenHeight = Int(navScroll.frame.size.height)
        
        self.petStats = UITableView(frame: CGRect(x: 0, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.petStats.delegate = self
        self.petStats.dataSource = self
        self.petStats.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.petStats)
        
        self.petMedication = UITableView(frame: CGRect(x: screenWidth, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.petMedication.delegate = self
        self.petMedication.dataSource = self
        self.petMedication.separatorStyle = .None
        self.petMedication.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.petMedication)
        
        self.petVaccination = UITableView(frame: CGRect(x: screenWidth*2, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.petVaccination.delegate = self
        self.petVaccination.dataSource = self
        self.petVaccination.separatorStyle = .None
        self.petVaccination.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.petVaccination)
        
        bgText.addSubview(self.navScroll)
        self.scrollView.addSubview(bgText)

        var contentHeight = bgText.frame.origin.y+barView.frame.origin.y+padding+64
        
        //enforce minimum height for scroll-ability:
        if (contentHeight < frame.size.height){
            contentHeight = frame.size.height+100
        }
        
        self.scrollView.contentSize = CGSizeMake(width, contentHeight)
        view.addSubview(self.scrollView)
        
//        self.getPets()
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        var petInfo = Dictionary<String, AnyObject>()
        petInfo["ownerId"] = [VFViewController.currentUser.id!]
        
        APIManager.getRequest("/api/pet", params: petInfo, completion: { response in
            
            if let results = response["results"] as? Array<Dictionary<String, AnyObject>>{
                
                for result in results {
                    let pet = VFPet()
                    pet.populate(result)
                    self.petsArray.append(pet)
                }
                
                self.petStats.reloadData()
            }
        })

    }
    
    func createPet(btn: UIButton){
        
        let addPetVc = VFCreatePetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
        
    }
    
    //MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        if tableView == self.petStats {
            count = self.petsArray.count
        }
        
        if tableView == self.petMedication{
            count = 10
        }
        
        if tableView == self.petVaccination{
            count = 5
        }
        
        return count!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.petStats {
            let pet = self.petsArray[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)
            cell.textLabel?.text = pet.name
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    //MARK: ScrollView Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y>0){
            self.petImage.transform = CGAffineTransformIdentity
            
            //span 0 to 250
            var frame = self.petImage.frame
            let offset = -0.4*scrollView.contentOffset.y
            frame.origin.y = offset
            self.petImage.frame = frame
            
            return
        }
        
        let delta = -scrollView.contentOffset.y //convert to positive
        
        // span 0 to 80
        let scale = 1+(delta/80)
        
        self.petImage.transform = CGAffineTransformMakeScale(scale, scale)
        
        switch scrollView.contentOffset.x {
        case 0:
            self.pageLabel.text = "General Information"
        case 414:
            self.pageLabel.text = "Medication"
        case 828:
            self.pageLabel.text = "Vaccinations"
        default:
            print("default")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
