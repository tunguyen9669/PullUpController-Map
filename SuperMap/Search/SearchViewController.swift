//
//  SearchViewController.swift
//  SuperMap
//
//  Created by admin on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MapKit
import PullUpController

class SearchViewController: PullUpController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
//    private var locations = [(title: String, location: CLLocationCoordinate2D)]()
    private var locations = [(origin: String, destination: String)]()
    
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
        portraitSize = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                              height: 150)
        landscapeFrame = CGRect(x: 5, y: 50, width: 280, height: 300)
        
        tableView.attach(to: self)
        setupDataSource()
        
        willMoveToStickyPoint = { point in
            print("willMoveToStickyPoint \(point)")
        }
        
        didMoveToStickyPoint = { point in
            print("didMoveToStickyPoint \(point)")
        }
        
        onDrag = { point in
            print("onDrag: \(point)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.cornerRadius = 12
    }
    
    // MARK: - PullUpController
    private func setupDataSource() {
//        locations.append(("Handico", CLLocationCoordinate2D(latitude: 21.016949, longitude:  105.781940)))
//        locations.append(("Milan", CLLocationCoordinate2D(latitude: 45.4625319, longitude: 9.1574741)))
//        locations.append(("Turin", CLLocationCoordinate2D(latitude: 45.0705805, longitude: 7.6593106)))
//        locations.append(("London", CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.2416817)))
//        locations.append(("Paris", CLLocationCoordinate2D(latitude: 48.8589507, longitude: 2.2770201)))
//        locations.append(("Amsterdam", CLLocationCoordinate2D(latitude: 52.354775, longitude: 4.7585401)))
//        locations.append(("Dublin", CLLocationCoordinate2D(latitude: 53.3244431, longitude: -6.3857869)))
//        locations.append(("Reykjavik", CLLocationCoordinate2D(latitude: 64.1335484, longitude: -21.9224815)))
//        locations.append(("London", CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.2416817)))
//        locations.append(("Paris", CLLocationCoordinate2D(latitude: 48.8589507, longitude: 2.2770201)))
//        locations.append(("Amsterdam", CLLocationCoordinate2D(latitude: 52.354775, longitude: 4.7585401)))
//        locations.append(("Dublin", CLLocationCoordinate2D(latitude: 53.3244431, longitude: -6.3857869)))
//        locations.append(("Reykjavik", CLLocationCoordinate2D(latitude: 64.1335484, longitude: -21.9224815)))
//        locations.append(("London", CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.2416817)))
//        locations.append(("Paris", CLLocationCoordinate2D(latitude: 48.8589507, longitude: 2.2770201)))
//        locations.append(("Amsterdam", CLLocationCoordinate2D(latitude: 52.354775, longitude: 4.7585401)))
//        locations.append(("Dublin", CLLocationCoordinate2D(latitude: 53.3244431, longitude: -6.3857869)))
//        locations.append(("Reykjavik", CLLocationCoordinate2D(latitude: 64.1335484, longitude: -21.9224815)))
        locations.append(("Toronto","Toronto"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        locations.append(("Toronto","Montreal"))
        
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let lastStickyPoint = pullUpControllerAllStickyPoints.last {
            pullUpControllerMoveToVisiblePoint(lastStickyPoint, animated: true, completion: nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        print(searchBar.text!)
        (parent as? MapViewController)?.getDirection(searchBar.text!, searchBar.text!)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell",
                                                     for: indexPath) as? SearchResultCell
            else { return UITableViewCell() }
        
        cell.configure(title: locations[indexPath.row].origin)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
//        pullUpControllerMoveToVisiblePoint(pullUpControllerMiddleStickyPoints[0], animated: true, completion: nil)
        
//        (parent as? MapViewController)?.zoom(to: locations[indexPath.row].location)
        let index = locations[indexPath.row]
//        (parent as? MapViewController)?.setupMap(Float(index.location.latitude), Float(index.location.longitude), index.title)
//        (parent as? MapViewController)?.getDirection(index.origin, index.destination)
        
    }
}

