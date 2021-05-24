//
//  ShowLoactionViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import MapKit

class ShowLocationViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: ShowLocationInteractorProtocol!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressEnterDetailView: AddressEnterDetailView!
    
    @IBOutlet weak var addressEnterDetailViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inactiveView: InactiveView!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.showsUserLocation = true
        self.addKeyboardWillShowObserver()
        self.inactiveView.delegate = self
        self.addressEnterDetailView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.initialSetup()
        self.addressEnterDetailView.setupAs(self.interactor.addressEnterDetailViewType)
        //        self.addressEnterDetailView.setupLocationLabelText(self.interactor.addressString)
    }
    
    //MARK: - @IBActions
    
    @IBAction func closeButtonTapped(_ sender: CloseMenuButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    
    private func initialSetup() {
        
        if let region = self.interactor.getLocationRegion() {
            self.mapView.setRegion(region, animated: false)
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userTapped(gestureReconizer:)))
        self.mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func userTapped(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state == .ended {
            let locationInView = gestureReconizer.location(in: self.mapView)
            let tappedCoordinate = self.mapView.convert(locationInView, toCoordinateFrom: self.mapView)
            self.interactor.getDestinationAddressText(for: tappedCoordinate)
            self.deleteAnnotation()
            self.addDestinationAnnotation(coordinate: tappedCoordinate)
        }
    }
}

//MARK: - Work with Map View

extension ShowLocationViewController {
    
    //Add Destination annotation
    
    private func addDestinationAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
    }
    
    private func deleteAnnotation() {
        self.mapView.removeAnnotations(self.mapView.annotations)
    }
    
}


//MARK: - MKMapViewDelegate

extension ShowLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //Annotation for user location
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.UserLocationReuseId.rawValue)
            annotationView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
            return annotationView
        }
        
        //Annotation for destination
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.DestinationLocation.rawValue)
        annotationView.image = UIImage(named: CustomImagesNames.userPinOrange.rawValue)
        return annotationView
    }
}

//MARK: - ShowLocationViewProtocol

extension ShowLocationViewController: ShowLocationViewProtocol {
    
    func popViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setAddressEnterDetailLocationTextFieldText(_ text: String) {
        DispatchQueue.main.async {
            self.addressEnterDetailView.setupLocationTextFieldText(text)
        }
    }
    
    func showMapRegion(region: MKCoordinateRegion?) {
        guard let region = region else { return }
        
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: false)
        }
    }
    
    func setAddressEnterDetailLocationLabelText(_ text: String?) {
        DispatchQueue.main.async {
            self.addressEnterDetailView.setupLocationLabelText(text)
        }
    }
}

//MARK: - Work with keyboard

extension ShowLocationViewController  {
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        self.keyboardWillShow(constraint: self.addressEnterDetailViewBottomConstraint, notification: notification, padding: 20, constraintConstant: 20)
        self.inactiveView.isHidden = false
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        
        self.keyboardWillHide(constraint: self.addressEnterDetailViewBottomConstraint, notification: notification, constraintConstant: 20)
        self.inactiveView.isHidden = true
    }
    
}

//MARK: - InactiveViewDelegate

extension ShowLocationViewController: InactiveViewDelegate {
    func userHasTapped() {
        self.addressEnterDetailView.endEditing(true)
    }
}

//MARK: - AddressEnterDetailViewDelegate

extension ShowLocationViewController: AddressEnterDetailViewDelegate {
    
    func mainButtonTapped(_ destinationAddressText: String) {
        self.interactor.transmitDestinationAddressToDelegate(destinationAddressText)
    }
}
