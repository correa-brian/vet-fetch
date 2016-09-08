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
    var vetLocations = Array<VFPlace>()

    override func loadView() {
        
        self.edgesForExtendedLayout = .None
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .redColor()
        
        self.vetTable = UITableView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.vetTable.delegate = self
        self.vetTable.dataSource = self
        self.vetTable.autoresizingMask = .FlexibleHeight
        self.vetTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        view.addSubview(self.vetTable)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .yellowColor()
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(VFViewController.exit))
        
        self.navigationItem.setRightBarButtonItem(add, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Tableview Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vetLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let place = self.vetLocations[indexPath.row]
        let cellId = "cellId"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.textLabel?.text = place.name
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
