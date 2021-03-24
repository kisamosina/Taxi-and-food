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
    
    private func initialSetup() {
        
        if let region = self.interactor.getLocationRegion() {
            self.mapView.setRegion(region, animated: false)
        }
        
    }
}


//MARK: - MKMapViewDelegate

extension ShowLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.UserLocationReuseId.rawValue)
            annotationView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
            return annotationView
        }
        return nil
    }
}

//MARK: - ShowLocationViewProtocol

extension ShowLocationViewController: ShowLocationViewProtocol {
    
    func showMapRegion(region: MKCoordinateRegion?) {
        guard let region = region else { return }
        
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: false)
        }
    }
    
    func setupAddressEnterDetailLocationLabelText(_ text: String?) {
        self.addressEnterDetailView.setupLocationLabelText(text)
    }
}

//MARK: - Work with keyboard

extension ShowLocationViewController  {
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        self.keyboardWillShow(constraint: self.addressEnterDetailViewBottomConstraint, notification: notification)
        self.inactiveView.isHidden = false
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        
        self.keyboardWillHide(constraint: self.addressEnterDetailViewBottomConstraint, notification: notification)
        self.inactiveView.isHidden = true
    }
    
}

//MARK: - InactiveViewDelegate

extension ShowLocationViewController: InactiveViewDelegate {
    func userHasTapped() {
        self.addressEnterDetailView.endEditing(true)
    }
    
        
    
}
