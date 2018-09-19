//
//  MapViewController.swift
//  SuperMap
//
//  Created by admin on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
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
    
    func zoom(to location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
    }

}
