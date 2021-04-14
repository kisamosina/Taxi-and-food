//
//  ShowLocationProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import MapKit

protocol ShowLocationViewProtocol: class {
    
    var interactor: ShowLocationInteractorProtocol! { get set }
    
    func showMapRegion(region: MKCoordinateRegion?)
    
    func setAddressEnterDetailLocationLabelText(_ text: String?)
    
    func setAddressEnterDetailLocationTextFieldText(_ text: String)
    
    func popViewController()
}

protocol ShowLocationInteractorProtocol: class {
    
    var view: ShowLocationViewProtocol! { get }
    
    var addressEnterDetailViewType: AddressEnterDetailViewType { get }
    
    var addressString: String? { get set }
    
    init(view: ShowLocationViewProtocol, userLocation: CLLocationCoordinate2D?, addressEnterDetailViewType: AddressEnterDetailViewType)
    
    func getLocationRegion() -> MKCoordinateRegion?
    
    func getDestinationAddressText(for loctaion: CLLocationCoordinate2D)
    
    func transmitDestinationAddressToDelegate(_ addressText: String)
    
    func drawPath()
}


protocol ShowLocationInteractorDelegate: class {
    func get(location: CLLocationCoordinate2D?, and addressText: String)
}
