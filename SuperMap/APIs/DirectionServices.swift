//
//  DirectionServices.swift
//  SuperMap
//
//  Created by admin on 9/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum TravelModes: String {
    case driving = "driving"
    case walking = "walking"
    case bicycling = "Bicycling"
    case transit = "transit"
}
class DirectionService: APIServiceObject {
    func getDirection(_ origin: String, _ destination: String, _ key: String, _ complite: @escaping (Result<DerectionOverview>)  -> Void) {
        let directionRequest = APIRequestProvider.sharedInstand.directionRequest(origin,
                                                                                 destination,
                                                                                 key)
        serviceAgent.startRequest(directionRequest) { (json, error) in
            if let error = error {
                complite(Result.failure(error))
            } else {
                print("JSON: \(json)")
                let location = DerectionOverview(json)
                complite(Result.success(location))
                
            }
        }
    }
}
