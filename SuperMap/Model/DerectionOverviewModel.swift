//
//  DerectionOverviewModel.swift
//  SuperMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class DerectionOverviewModel: NSObject {
    var geocodedWaypoints: [GeocodedWaypointDTO]
    var routes: [RouteDTO]
    var status: String
    
    init(_ direction: DerectionOverview) {
        self.geocodedWaypoints = direction.geocodedWaypoints
        self.routes = direction.routes
        self.status = direction.status
    }
   
}
