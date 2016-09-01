//
//  VFVetMapViewController.swift
//  Vet-Fetch
//
//  Created by Brian Correa on 8/30/16.
//  Copyright © 2016 Milkshake Tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class VFVetMapViewController: VFViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
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
        view.backgroundColor = .redColor()
        
        self.mapView = MKMapView(frame: frame)
        self.mapView.delegate = self
        view.addSubview(mapView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        self.tabBarController?.tabBar.barTintColor = UIColor.blackColor()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 166/255, green: 207/255, blue: 190/255, alpha: 1)
    }
    
    // MARK: LocationManager Delegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if (status == .AuthorizedWhenInUse){
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("didUpdateLocations: \(locations)")
        self.locationManager.stopUpdatingLocation()
        self.currentLocation = locations[0]
        
        self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.currentLocation!.coordinate.latitude, self.currentLocation!.coordinate.longitude)
        
        let dist = CLLocationDistance(500)
        let region = MKCoordinateRegionMakeWithDistance(self.mapView.centerCoordinate, dist, dist)
        self.mapView.setRegion(region, animated: true)
        
        let latLng = "\(self.currentLocation!.coordinate.latitude),\(self.currentLocation!.coordinate.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latLng)&radius=1500&types=veterinary_care&key=AIzaSyAMiWIQf7fTP1AxUpyY_qBVDFooHgBaimQ"
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let results = json["results"] as? Array<Dictionary<String, AnyObject>>{
                
                    for result in results {
                        print("Results: -----\(result)")
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
