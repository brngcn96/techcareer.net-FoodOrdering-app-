//
//  MapViewController.swift
//  Pods
//
//  Created by Baran Göcen on 17.12.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //konum
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //harita
        //41.040673,28.9842673
       let konum = CLLocationCoordinate2D(latitude: 41.040673, longitude: 28.9842673)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapView.setRegion(bolge, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = konum
        pin.title = "Taksim"
        pin.subtitle = "Meydan"
        mapView.addAnnotation(pin)
    }
    


}
