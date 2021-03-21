//
//  ShowLoactionViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import MapKit

class ShowLoactionViewController: UIViewController {
    
    //MARK: - Properties
    
    private var region: MKCoordinateRegion?
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showMapRegion()
    }
    
    //MARK: - Methods
    
    public func setMapRegion(_ region: MKCoordinateRegion?) {
        self.region = region
    }
    
    private func showMapRegion() {
        guard let region = self.region else { return }
        self.mapView.setRegion(region, animated: true)
    }
    
    //MARK: - Close button tapped
    
    @IBAction func closeButtonTapped(_ sender: CloseMenuButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - MKMapViewDelegate

extension ShowLoactionViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.UserLocationReuseId.rawValue)
            annotationView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
            return annotationView
        }
        return nil
    }
}
