//
//  VFPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetViewController: VFViewController {
    
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
        
        let width = frame.size.width
        let height = frame.size.height
        
        self.petImage = UIImageView(frame: CGRectMake(0, 0, width, height))
        self.petImage.image = UIImage(named: "account_background.png")
        self.petImage.backgroundColor = UIColor.whiteColor()
        view.addSubview(self.petImage)
        
        let dimen = height*0.50
        
        self.container = UIView(frame: CGRect(x: 0, y: dimen, width: width, height: height-dimen))
        self.container.backgroundColor = .clearColor()
        
        let petNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.5, height: height*0.125))
        petNameLabel.textColor = .whiteColor()
        petNameLabel.backgroundColor = UIColor.blueColor()
        petNameLabel.textAlignment = .Right
        petNameLabel.font = UIFont(name: "DiwanMishafi" , size: 32)
        petNameLabel.text = "Milkshake"
        self.container.addSubview(petNameLabel)
        
        let x = petNameLabel.frame.size.width+15
        
        let circle = UIView(frame: CGRect(x: x, y: petNameLabel.frame.size.height*0.5-8, width: 16, height: 16))
        circle.layer.borderWidth = 2.0
        circle.layer.borderColor = UIColor.greenColor().CGColor
        circle.layer.cornerRadius = 8
        circle.backgroundColor = UIColor.clearColor()
        self.container.addSubview(circle)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: petNameLabel.frame.size.height, width: width, height: self.container.frame.size.height)
        blurredEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = CGRect(x: 0, y: petNameLabel.frame.size.height, width: width, height: self.container.frame.size.height)
        
        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        self.container.addSubview(blurredEffectView)
        
        view.addSubview(self.container)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    func createPet(btn: UIButton){
        
        let addPetVc = VFCreatePetViewController()
        self.presentViewController(addPetVc, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
