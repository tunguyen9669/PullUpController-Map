//
//  Bounds.swift
//  SuperMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Bounds: NSObject {
    var northeast: LocationDTO
    var southwest: LocationDTO
    init(_ bounds: BoundsDTO) {
        self.northeast = bounds.northeast
        self.southwest = bounds.southwest
    }
}
