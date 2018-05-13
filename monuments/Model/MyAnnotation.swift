//
//  MyAnnotation.swift
//  monuments
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    let image = #imageLiteral(resourceName: "Group")
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, address: String, coord: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = address
        self.coordinate = coord
        super.init()
    }
}
