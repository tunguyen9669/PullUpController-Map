//
//  MapViewController.swift
//  SuperMap
//
//  Created by admin on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBAction func reduceZoom(_ sender: Any) {
    }
    @IBAction func increaseZoom(_ sender: Any) {
    }
    let locationManager = CLLocationManager()
    var zoom: Float = 6.0
    
    @IBOutlet weak var mapView: GMSMapView!
    private func makeSearchViewControllerIfNeeded() -> SearchViewController {
        let currentPullUpController = childViewControllers
            .filter({ $0 is SearchViewController })
            .first as? SearchViewController
        if let currentPullUpController = currentPullUpController {
            return currentPullUpController
        } else {
            return SearchViewController(nibName: "SearchViewController", bundle: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
//        mapView.delegate = self
        setupNavigation()
        addPullUpController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupNavigation() {
        navigationItem.title = "MAP MAP MAP"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onRight))
    }
    
    @objc func onLeft() {
        print("left")
        guard
            childViewControllers.filter({ $0 is SearchViewController }).count == 0
            else { return }
        addPullUpController()
    }
    @objc func onRight() {
        print("right")
        let pullUpController = makeSearchViewControllerIfNeeded()
        removePullUpController(pullUpController, animated: true)
        
    }
    private func addPullUpController() {
        let pullUpController = makeSearchViewControllerIfNeeded()
        addPullUpController(pullUpController, animated: true)
    }
    
//    func zoom(to location: CLLocationCoordinate2D) {
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegionMake(location, span)
//
//        mapView.setRegion(region, animated: true)
//    }
    func setupMap(_ latitude: Float, _ longtitude: Float, _ title: String) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longtitude), zoom: 15.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longtitude))
        marker.title = title
        marker.map = mapView
    }
}
extension MapViewController: CLLocationManagerDelegate {
    //Handle incoming location events.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location: CLLocation = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: locationLatitude, longitude: locationLongtitude, zoom: zoomLevel)
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
