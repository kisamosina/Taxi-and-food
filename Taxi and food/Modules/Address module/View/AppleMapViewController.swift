//
//  AppleMapViewController.swift
//  Taxi and food
//
//  Created by mac on 09/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import MapKit

protocol AppleMapDelegateProtocol {
    func send(address: String)
    
}

class AppleMapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    var delegate: AppleMapDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(revealRegionDetailsWithLongPressOnMap))
        lpgr.delegate = self
        self.mapView.addGestureRecognizer(lpgr)
        
        attemtLocationAccess()
        mapView.delegate = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func attemtLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")

        self.convertLatLongToAddress(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)

    }


    
// Converting lan and long tp the address

func convertLatLongToAddress(latitude: Double, longitude: Double) {
    
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: latitude, longitude: longitude)
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        // Place details
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]

        // Street address
        if let street = placeMark.thoroughfare, let house = placeMark.subThoroughfare {
            
            let stringAddress = "\(street), \(house)"
            self.delegate?.send(address: stringAddress)

            print(stringAddress)
            self.performSegue(withIdentifier: "Address", sender: self)
        }


    })
    }
}


private extension MKMapView {
    
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
        ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}


extension AppleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return }
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = manager.location?.coordinate {
           let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(viewRegion, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "You"
            annotation.subtitle = "Current location"
            mapView.addAnnotation(annotation)

        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
    }
    
}
