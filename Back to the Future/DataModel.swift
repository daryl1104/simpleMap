//
//  DataModel.swift
//  Back to the Future
//
//  Created by daryl on 2023/5/9.
//

import Foundation
class VisitedPoint: Codable {
    var latitude: String
    var longitude: String
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
