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
    @IBAction func reduceZoom(_ sender: Any) {
    }
    @IBAction func increaseZoom(_ sender: Any) {
    }
    @IBAction func direction(_ sender: Any) {
    }
    
    @IBOutlet weak var startLocation: UIButton!
    @IBOutlet weak var endLocation: UIButton!
    @IBAction func openEndLocation(_ sender: Any) {
    }
    
    @IBAction func openStartLocation(_ sender: Any) {
    }
    
    @IBOutlet weak var separatorSearchView: UIView!{
        didSet {
            separatorSearchView.layer.cornerRadius = separatorSearchView.frame.height/2
        }
    }
    
//    private var locations = [(title: String, location: CLLocationCoordinate2D)]()
   
    
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        portraitSize = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                              height: 250)
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
    // MARK: - PullUpController

    override var pullUpControllerPreferredSize: CGSize {
        return portraitSize
    }

    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return landscapeFrame
    }
//
//    override var pullUpControllerPreviewOffset: CGFloat {
//        return view.frame.height
//    }
//
//    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
//        return [view.frame.maxY]
//    }
//
//    override var pullUpControllerIsBouncingEnabled: Bool {
//        return false
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.cornerRadius = 12
    }
  
}




