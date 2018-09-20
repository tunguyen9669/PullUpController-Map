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
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
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
        let directionService = DirectionService()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        directionService.getDirection("Toronto", "Montreal", API_KEY) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let location):
                let direction = DerectionOverviewModel(location)
                for item in direction.routes {
                    print(item.bounds.northeast.latitude)
                    print("Latitude")
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
       
                           
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
        setupNavigation()
        addPullUpController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDirection(_ origin: String, _ destination: String) {
        let directionService = DirectionService()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        directionService.getDirection(origin, destination, API_KEY) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let location):
                let direction = DerectionOverviewModel(location)
                for item in direction.routes {
                    let latitude = item.bounds.northeast.latitude
                    let longtitude = item.bounds.southwest.longtitude
                    self.setupMap(Float(latitude), Float(longtitude), destination)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longtitude), zoom: 6.0)
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
            let locationLatitude = location.coordinate.latitude
            let locationLongtitude = location.coordinate.longitude
            self.originLatitude = locationLatitude
            self.originLongtitude = locationLongtitude
            let camera = GMSCameraPosition.camera(
                withLatitude: locationLatitude,
                longitude: locationLongtitude, zoom: 15.0)
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

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.destinationLatitude = coordinate.latitude
        self.destinationLongtitude = coordinate.longitude
        let marker = GMSMarker(position: coordinate)
        marker.map = self.mapView
    }
}

