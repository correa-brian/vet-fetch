//
//  VFVetTableViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/30/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import Alamofire

class VFVetTableViewController: VFViewController, UITableViewDelegate, UITableViewDataSource {
    
    var vetTable: UITableView!

    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .blackColor()
        
        self.vetTable = UITableView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height-49))
        self.vetTable.delegate = self
        self.vetTable.dataSource = self
        self.vetTable.autoresizingMask = .FlexibleTopMargin
        self.vetTable.autoresizingMask = .FlexibleBottomMargin
        self.vetTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        view.addSubview(self.vetTable)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.759211,-73.984638&radius=500&types=food&key=AIzaSyAMiWIQf7fTP1AxUpyY_qBVDFooHgBaimQ"
//
//        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
//            if let JSON = response.result.value as? Dictionary<String, AnyObject>{
//                print("JSON: \(JSON)")
//            }
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    //MARK: Tableview Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
