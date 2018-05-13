//
//  MyGeocoder.swift
//  monuments
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import CoreLocation

typealias AdressCompletion = (_ address: String?, _ error: String?) -> (Void)

class MyGeocoder {
    static let getMyGeocoder = MyGeocoder()
    
    func addressGeo(_ location: CLLocation, completion: AdressCompletion?) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarke, error) in
            if let err = error {
                completion?(nil, err.localizedDescription)
            } else if let array = placeMarke, array.count > 0 {
                let myPostion = array.last
                let number = myPostion?.subThoroughfare ?? ""
                let street = myPostion?.thoroughfare ?? ""
                let city = myPostion?.locality
                let address = number + " " + street + " " + city!
                completion?(address, nil)
            } else {
                completion?(nil, "Une erreur survenue")
            }
        })
    }
}
