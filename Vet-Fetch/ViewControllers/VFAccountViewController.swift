//
//  VFAccountViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/20/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFAccountViewController: VFViewController {
    
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
        view.backgroundColor = UIColor(red: 164/255, green: 185/255, blue: 202/255, alpha: 1)
        
        print("Current User: \(VFViewController.currentUser.id)")
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewDidAppear")
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func userLoggedIn(notification: NSNotification){
        super.userLoggedIn(notification)
        
        if(VFAccountViewController.currentUser.id == nil) {
            return
        }
        
        print("VFAccountViewController: userLoggedIn")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
