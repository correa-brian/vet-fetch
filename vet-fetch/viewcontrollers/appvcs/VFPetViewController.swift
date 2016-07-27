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
    var genInfoTableView: UITableView!
    var medicationTableView: UITableView!
    var vaccinationTableView: UITableView!
    
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
        
        let padding = CGFloat(20)
        let width = frame.size.width-2*padding
        
        let barView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 82.5))
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
        
//        self.petNameLabel = UILabel(frame: CGRect(x: padding, y: y, width: width, height: 18))
//        self.petNameLabel.textColor = .darkGrayColor()
//        self.petNameLabel.font = font
//        self.petNameLabel.text = pet.name
//        barView.addSubview(self.petNameLabel)
        
        let x = frame.size.width-88
        
        let addPetBtn = UIButton(type: .Custom)
        addPetBtn.frame = CGRect(x: x, y: 20, width: 44, height: 44)
        addPetBtn.backgroundColor = UIColor.redColor()
        addPetBtn.addTarget(self, action: #selector(VFPetViewController.btnTapped(_:)), forControlEvents: .TouchUpInside)
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

//        let colors = [UIColor.redColor(),UIColor.blueColor(), UIColor.greenColor()]
//        
//        for color in colors {
//            let index = colors.indexOf(color)
//            let xOrigin = index!*Int(frame.size.width)
//            let backgroundColor = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: screenWidth, height: screenHeight))
//            backgroundColor.backgroundColor = color
//            self.navScroll.addSubview(backgroundColor)
//        }
        
        self.genInfoTableView = UITableView(frame: CGRect(x: 0, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.genInfoTableView.delegate = self
        self.genInfoTableView.dataSource = self
        self.genInfoTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.genInfoTableView)
        
        self.medicationTableView = UITableView(frame: CGRect(x: screenWidth, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.medicationTableView.delegate = self
        self.medicationTableView.dataSource = self
        self.medicationTableView.separatorStyle = .None
        self.medicationTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.medicationTableView)
        
        self.vaccinationTableView = UITableView(frame: CGRect(x: screenWidth*2, y:0, width: screenWidth, height: screenHeight), style: .Plain)
        self.vaccinationTableView.delegate = self
        self.vaccinationTableView.dataSource = self
        self.vaccinationTableView.separatorStyle = .None
        self.vaccinationTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        self.navScroll.addSubview(self.vaccinationTableView)
        
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
                
                self.genInfoTableView.reloadData()
            }
        })

    }
    
    func btnTapped(btn: UIButton){
        print("addPet")
        
        let addPetVc = VFAddPetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
        
    }
    
    //MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        if tableView == self.genInfoTableView {
            count = self.petsArray.count
        }
        
        if tableView == self.medicationTableView{
            count = 10
        }
        
        if tableView == self.vaccinationTableView{
            count = 5
        }
        
        return count!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("\(indexPath.row)")
        
        if tableView == self.genInfoTableView {
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
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.x)")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollViewDidScroll-Y: \(scrollView.contentOffset.y)")
        
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
        
        print("scrollViewDidScroll: \(scrollView.contentOffset.x)")
        
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
