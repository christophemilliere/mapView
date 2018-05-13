//
//  CLLocationExtension.swift
//  monuments
//
//  Created by christophe milliere on 12/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    func setupLocation() {
        locationManager.delegate = self
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            locationManager.stopUpdatingLocation()
            let myPostion = locations[0]
            let coords = myPostion.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            let region = MKCoordinateRegion(center: coords, span: span)
            mapview.setRegion(region, animated: true)
        }
    }
}
