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
        
        view.addSubview(self.petImage)
        
        let dimen = height*0.50
        
        self.container = UIView(frame: CGRect(x: 0, y: dimen, width: width, height: height-dimen))
        self.container.backgroundColor = .clearColor()
        
        let petNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.5, height: height*0.125))
        petNameLabel.textColor = .whiteColor()
        petNameLabel.textAlignment = .Right
        petNameLabel.font = UIFont(name: "PingFangTC-Medium" , size: 30)
        petNameLabel.text = "Milkshake"
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
        petBreedLabel.text = "Bulldog"
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
        
        x = width*0.2
        var y = height*0.15
        
        for _ in 0..<2 {
            let button = UIButton(frame: CGRect(x: x, y: y, width: 32, height: 32))
            button.backgroundColor = .blueColor()
            self.container.addSubview(button)
            x += width*0.60-32
        }
        
        x = width*0.2
        y = height*0.25
        
        for _ in 0..<2 {
            let button = UIButton(frame: CGRect(x: x, y: y, width: 32, height: 32))
            button.backgroundColor = .blueColor()
            self.container.addSubview(button)
            x += width*0.60-32
        }
        
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
