//
//  FirstViewController.swift
//  Back to the Future
//
//  Created by daryl on 2023/5/9.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        updatePin()
    }
    
    func updatePin() {
        if let old = StorageManeger.getVisitedPoint() {
            let pointAnn = MKPointAnnotation()
            pointAnn.coordinate.latitude = Double(old.latitude)!
            pointAnn.coordinate.longitude = Double(old.longitude)!
            pointAnn.title = "I was here!"
            pointAnn.subtitle = "remember?"
            mapView.addAnnotation(pointAnn)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse else {
            print("please allow!!")
            return
        }
        print("DEBUG allowed")
        mapView.showsUserLocation = true
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        print("DEBUG tapped")
        let coordinate = locationManager.location?.coordinate
        if let latitude = coordinate?.latitude {
            print("DEBUG latitude: \(latitude)")
            if let longitude = coordinate?.longitude {
                print("DEBUG longitude: \(longitude)")
                // save
                let visitedPoint = VisitedPoint(latitude: String(latitude), longitude: String(longitude))
                StorageManeger.storeVisitedPoint(visitedPoint: visitedPoint)
                // remove old pin
                mapView.removeAnnotations(mapView.annotations)
                updatePin()
            }
        }
    }
    
    @IBAction func selfLocationTapped(_ sender: UIBarButtonItem) {
        if let coordinator = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinator, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
}
