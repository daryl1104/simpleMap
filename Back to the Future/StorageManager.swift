//
//  StorageManager.swift
//  Back to the Future
//
//  Created by daryl on 2023/5/9.
//

import Foundation
struct StorageKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let visitedPointKey = "visitedPoint"
}
class StorageManeger {
    static let storage: UserDefaults = UserDefaults.standard
    static func storeVisitedPoint(visitedPoint: VisitedPoint) {
        do {
            let data = try JSONEncoder().encode(visitedPoint)
            storage.setValue(data, forKey: StorageKey.visitedPointKey)
            storage.synchronize()
            print("DEBUG save success!")
        } catch {
            print("DEBUG ERROR: save error!")
        }
        
    }
    static func getVisitedPoint() -> VisitedPoint? {
        if let data = storage.data(forKey: StorageKey.visitedPointKey) {
            do {
                let visitedPoint = try JSONDecoder().decode(VisitedPoint.self, from: data)
                return visitedPoint
            } catch {
                print("DEBUG ERROR: decode error!")
            }
        }
        return nil
    }
    
    
}
