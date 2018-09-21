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

//    private var locations = [(title: String, location: CLLocationCoordinate2D)]()
   
    
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        portraitSize = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                              height: 150)
        landscapeFrame = CGRect(x: 5, y: 50, width: 280, height: 300)
        
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
  
}




