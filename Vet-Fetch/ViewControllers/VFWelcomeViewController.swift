//
//  VFWelcomeViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/21/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFWelcomeViewController: VFViewController, UIScrollViewDelegate {

    var loginButtons = Array<UIButton>()
    var appNameLabel: UILabel!
    var backgroundScrollView: UIScrollView!
    var pageControl: UIPageControl!
    var backgroundImage: UIImageView!
    var backgroundOverlay: UIImageView!
    
    var imagesArray = ["account_background.png", "account_background2.png", "account_background3.png"]
    
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
        view.backgroundColor = .blueColor()
        
        let w = self.imagesArray.count*Int(frame.size.width)
        let screenWidth = Int(frame.size.width)
        let screenHeight = Int(frame.size.height)
        
        self.backgroundScrollView = UIScrollView(frame: frame)
        self.backgroundScrollView.contentSize = CGSize(width: w, height: 0)
        self.backgroundScrollView.pagingEnabled = true
        self.backgroundScrollView.delegate = self
        view.addSubview(self.backgroundScrollView)
        
        for image in self.imagesArray {
            let index = self.imagesArray.indexOf(image)
            let xOrigin = index!*Int(frame.size.width)
            self.backgroundImage = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: screenWidth, height: screenHeight))
            self.backgroundImage.image = UIImage(named: image)
            self.backgroundScrollView.addSubview(backgroundImage)
        }
        
        self.backgroundImage.alpha = 0.75
        
        self.backgroundOverlay = UIImageView(frame: frame)
        self.backgroundOverlay.backgroundColor = .whiteColor()
        self.backgroundOverlay.alpha = 0.25
        view.addSubview(backgroundOverlay)
        
        let padding = CGFloat(Constants.padding)
        let width = frame.size.width-2*padding
        let height = CGFloat(44)
        var y = CGFloat(frame.size.height*0.60)
        
        self.pageControl = UIPageControl(frame: CGRect(x: padding, y: y, width: width, height: 20))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1
        y += self.pageControl.frame.size.height
        view.addSubview(self.pageControl)
        
        self.appNameLabel = UILabel(frame: CGRect(x: padding, y: y, width: width, height: 44))
        self.appNameLabel.textAlignment = .Center
        self.appNameLabel.text = "Vet Fetch"
        self.appNameLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        self.appNameLabel.textColor = UIColor.whiteColor()
        y += self.appNameLabel.frame.size.height + padding
        view.addSubview(self.appNameLabel)
        
        let offScreen = frame.size.height
        
        let buttonTitles = ["Already have an account? Sign in", "Join with Email"]
        
        for btnTitle in buttonTitles {
            let btn = UIButton(frame: CGRect(x:padding, y: offScreen, width: width, height: height))
            btn.setTitle(btnTitle, forState: .Normal)
            btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65)
            btn.layer.borderColor = UIColor.whiteColor().CGColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 7.5
            btn.titleLabel?.font = UIFont(name: "Arial", size: 16)
            
            btn.tag = Int(y)
            btn.addTarget(self, action: #selector(VFWelcomeViewController.showNextController(_:)), forControlEvents: .TouchUpInside)
            
            view.addSubview(btn)
            self.loginButtons.append(btn)
            y += height + padding
        }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateButtons()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func userLoggedIn(notification: NSNotification){
        super.userLoggedIn(notification)
        
        if(VFViewController.currentUser.id == nil) {
            return
        }
        
        self.showAccountVc()
    }
    
    func animateButtons(){
        for i in 0..<self.loginButtons.count {
            UIView.animateWithDuration(1.50,
                                       delay: (0.5+Double(i)*0.1),
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0,
                                       options: .CurveEaseInOut,
                                       animations: {
                                        
                                        let button = self.loginButtons[i]
                                        var frame = button.frame
                                        frame.origin.y = CGFloat(button.tag)
                                        button.frame = frame
                },
                                       completion: nil)
        }
    }
    
    func showAccountVc(){
        let accountVc = VFAccountViewController()
        self.navigationController?.pushViewController(accountVc, animated: true)
    }
    
    func showNextController(sender: UIButton){
        
        let buttonTitle = sender.titleLabel?.text?.lowercaseString
        
        if(buttonTitle == "already have an account? sign in"){
            let loginVc = VFLoginViewController()
            self.presentViewController(loginVc, animated: true, completion: nil)
        }
        
        if(buttonTitle == "join with email"){
            let registerVc = VFRegisterViewController()
            self.presentViewController(registerVc, animated: true, completion: nil)
        }
        
    }
    
    //MARK: ScrollView Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.x)")
        let offset = scrollView.contentOffset.x
        
        if (offset == 0){
            self.pageControl.currentPage = 0
        }
        
        if (offset == self.view.frame.size.width){
            self.pageControl.currentPage = 1
        }
        
        if (offset == self.view.frame.size.width*2){
            self.pageControl.currentPage = 2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
