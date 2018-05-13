//
//  MapViewController.swift
//  monuments
//
//  Created by christophe milliere on 12/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var myPostion: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    
    let urlString = "https://www.data.gouv.fr/s/resources/monuments-historiques-francais/20150408-163911/monuments.json"
    var locationManager = CLLocationManager()
    var monuments = [Monument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.showsUserLocation = true
        mapview.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        setupLocation()
        getDataJson()

    }
    
    func getDataJson() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else { return }
            do{
                print("Data : \(data)")
                self.monuments = try JSONDecoder().decode([Monument].self, from: data!)
                DispatchQueue.main.async {
                    self.getAnnotation()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }

    func getAnnotation(){
        for monument in self.monuments {
            if let latString = monument.latitude, let lngString = monument.longitude {
                if let lat = Double(latString), let lng = Double(lngString) {
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    let title = monument.name ?? ""
                    let location = CLLocation(latitude: lat, longitude: lng)
                    MyGeocoder.getMyGeocoder.addressGeo(location) { (address, error) -> (Void) in
                        var myAddress = ""
                        if address != nil {
                            myAddress = address!
                        }
                        let myAnnotation = MyAnnotation(title: title, address: myAddress, coord: coordinate)
                        self.mapview.addAnnotation(myAnnotation)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0: mapview.mapType = .standard
        case 1: mapview.mapType = .satellite
        case 2: mapview.mapType = .hybrid
        default: break
        }
    }
    
    @IBAction func locationAtion(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
