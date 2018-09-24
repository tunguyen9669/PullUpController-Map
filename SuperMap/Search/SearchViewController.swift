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
    
    @IBOutlet weak var secondView: UIView!
    @IBAction func increaseZoom(_ sender: Any) {
        (parent as? MapViewController)?.increaseZoom()
        print((parent as? MapViewController)?.zoom)
    }
    @IBAction func reduceZoom(_ sender: Any) {
        (parent as? MapViewController)?.reduceZoom()
        print((parent as? MapViewController)?.zoom)
    }
    
    @IBAction func onDirection(_ sender: Any) {
        (parent as? MapViewController)?.check()
    }
    @IBOutlet weak var sepatorView: UIView! {
        didSet {
            sepatorView.layer.cornerRadius = sepatorView.frame.height/2
        }
    }
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var menuView: UIView!
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func setupView() {
        portraitSize = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                              height: secondView.frame.maxY)
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
    // MARK: - PullUpController
    override var pullUpControllerPreferredSize: CGSize {
        return portraitSize
    }
    
    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return landscapeFrame
    }
    override var pullUpControllerPreviewOffset: CGFloat {
        return menuView.frame.height
    }
    
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return [firstView.frame.maxY]
    }
    
    override var pullUpControllerIsBouncingEnabled: Bool {
        return false
    }
  
}




