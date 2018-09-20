//
//  Location.swift
//  SuperMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Location: NSObject {
    var latitude = 0.0
    var longtitude = 0.0
    
    init(_ location: LocationDTO) {
        self.latitude = location.latitude
        self.longtitude = location.longtitude
    }
}
