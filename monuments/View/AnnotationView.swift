//
//  AnnotationView.swift
//  monuments
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import MapKit

class AnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet{
            guard let new = newValue as? MyAnnotation else { return }
            image = #imageLiteral(resourceName: "Group")
        }
    }
}
