//
//  VFPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetViewController: VFViewController, UIScrollViewDelegate {
    
    var petImage: UIImageView!
    var scrollView: UIScrollView!
    var navScroll: UIScrollView!
    var pageLabel: UILabel!
    
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
        lblUsername.text = "Hi Brian"
        barView.addSubview(lblUsername)
        y += lblUsername.frame.size.height
        
        let btnsArray = ["1", "2", "3"]
        
        var x = frame.size.width-44
        
        for btnTitle in btnsArray {
            
            let btn = UIButton(frame: CGRect(x: x, y: 5, width: 44, height: 44))
            btn.setTitle(btnTitle, forState: .Normal)
            btn.backgroundColor = UIColor.blueColor()
            btn.layer.borderColor = UIColor.whiteColor().CGColor
            btn.layer.borderWidth = 2
            btn.titleLabel?.font = UIFont(name: "Arial", size: 16)
            btn.addTarget(self, action: #selector(VFPetViewController.btnTapped(_:)), forControlEvents: .TouchUpInside)
            
            barView.addSubview(btn)
            x -= btn.frame.size.height+10
        }
        
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
//        self.navScroll.alwaysBounceHorizontal = false
        self.navScroll.delegate = self
        
        let screenWidth = Int(navScroll.frame.size.width)
        let screenHeight = Int(navScroll.frame.size.height)

        let colors = [UIColor.redColor(),UIColor.blueColor(), UIColor.greenColor()]
        
        for color in colors {
            let index = colors.indexOf(color)
            let xOrigin = index!*Int(frame.size.width)
            let backgroundColor = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: screenWidth, height: screenHeight))
            backgroundColor.backgroundColor = color
            self.navScroll.addSubview(backgroundColor)
        }
        
        bgText.addSubview(self.navScroll)
        
        self.scrollView.addSubview(bgText)

        var contentHeight = bgText.frame.origin.y+barView.frame.origin.y+padding+64
        
        //enforce minimum height for scroll-ability:
        if (contentHeight < frame.size.height){
            contentHeight = frame.size.height+100
        }
        
        self.scrollView.contentSize = CGSizeMake(width, contentHeight)
        
        view.addSubview(self.scrollView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
    }
    
    func btnTapped(btn: UIButton){
        print("btnTapped")
        
//        switch btn.titleLabel {
//        case "1":
//                self.navScroll.contentOffset.x = 0
//        case "2":
//            self.navScroll.contentOffset.x =
//        case "3":
//            self.navScroll.contentOffset.x = 0
//        }
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
