//
//  VFPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/9/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetViewController: VFViewController {
    
    var pet: VFPet?
    var petImage: UIImageView!
    var petNameLabel: UILabel!
    
    var container: UIView!
    var addPetBtn: UIButton!
    
    //MARK: - Lifecycle Methods
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView(){
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .whiteColor()
        
        let width = CGFloat(frame.size.width)
        let height = CGFloat(frame.size.height)
        
        self.petImage = UIImageView(frame: CGRectMake(0, 0, width, height))
        self.petImage.image = UIImage(named: "account_background2.png")
        self.petImage.backgroundColor = UIColor.whiteColor()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        gradientLayer.colors = [UIColor.clearColor().CGColor, black.CGColor]
        gradientLayer.locations = [0.0, 0.6]
        self.petImage.layer.addSublayer(gradientLayer)
        view.addSubview(self.petImage)
        
        let dimen = height*0.50
        
        self.container = UIView(frame: CGRect(x: 0, y: dimen, width: width, height: height-dimen))
        self.container.backgroundColor = .clearColor()
        
        let petNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.5, height: height*0.125))
        petNameLabel.textColor = .whiteColor()
        petNameLabel.textAlignment = .Right
        petNameLabel.font = UIFont(name: "PingFangTC-Medium" , size: 30)
        petNameLabel.text = pet!.name
        self.container.addSubview(petNameLabel)
        
        var x = petNameLabel.frame.size.width+20
        
        let circle = UIView(frame: CGRect(x: x, y: petNameLabel.frame.size.height*0.5-8, width: 16, height: 16))
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor = UIColor.greenColor().CGColor
        circle.layer.cornerRadius = 8
        circle.backgroundColor = UIColor.clearColor()
        self.container.addSubview(circle)
        x += circle.frame.size.width + 20
        
        let verticalLine = UIView(frame: CGRect(x: x, y: 0, width: 0.5, height: petNameLabel.frame.size.height))
        verticalLine.backgroundColor = UIColor.whiteColor()
        verticalLine.alpha = 0.7
        self.container.addSubview(verticalLine)
        x += verticalLine.frame.size.width + 20
        
        let petBreedLabel = UILabel(frame: CGRect(x: x, y: 0, width: width*0.25, height: height*0.125))
        petBreedLabel.textColor = .orangeColor()
        petBreedLabel.textAlignment = .Left
        petBreedLabel.font = UIFont(name: "PingFangTC-Medium" , size: 15)
        petBreedLabel.text = pet!.breed
        self.container.addSubview(petBreedLabel)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: petNameLabel.frame.size.height, width: width, height: self.container.frame.size.height)
        blurredEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = CGRect(x: 0, y: petNameLabel.frame.size.height, width: width, height: self.container.frame.size.height)
        
        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        self.container.addSubview(blurredEffectView)
        
        let dimenW = CGFloat(100)
        let dimenH = CGFloat(36)
        x = width*0.10
        var y = petNameLabel.frame.size.height+height*0.05
        
        var text = [pet!.breed, pet!.weight]
        var icons = ["paw_icon.png", "weight_icon.png"]
        
        for i in 0..<text.count {
            let label = UILabel(frame: CGRect(x: x, y: y, width: dimenW, height: dimenH))
            label.text = text[i]
            label.textColor = .whiteColor()
            label.textAlignment = .Right
            
            let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: dimenH, height: dimenH))
            icon.image = UIImage(named: icons[i])
            icon.tintColor = .whiteColor()
            
            label.addSubview(icon)
            
            self.container.addSubview(label)
            x += width*0.50
        }
        
        text = [pet!.birthday, pet!.sex]
        icons = ["DOB_icon.png", "sex_icon.png"]
        
        x = width*0.10
        let offset = height*0.50 - (49+height*0.05+dimenH)
        y = offset
        
        for i in 0..<text.count {
            let label = UILabel(frame: CGRect(x: x, y: y, width: dimenW, height: dimenH))
            label.text = text[i]
            label.textColor = .whiteColor()
            label.textAlignment = .Right
            
            let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: dimenH, height: dimenH))
            icon.image = UIImage(named: icons[i])
            icon.tintColor = .whiteColor()
            
            label.addSubview(icon)
            self.container.addSubview(label)
            x += width*0.50
        }
        view.addSubview(self.container)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pet!.imageUrl.characters.count == 0 {
            return
        }
        if pet!.imageData != nil {
            self.petImage.image = pet!.imageData
            return
        }
        pet!.fetchOriginalImage({ image in
            self.petImage.image = image
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .clearColor()
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.tabBarController?.tabBar.barTintColor = UIColor.blackColor()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 166/255, green: 207/255, blue: 190/255, alpha: 1)
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(createPet(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = add
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func createPet(btn: UIButton){
        let addPetVc = VFCreatePetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}