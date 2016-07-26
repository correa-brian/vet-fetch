//
//  VFPetViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 7/25/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit

class VFPetViewController: VFViewController {
    
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
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
