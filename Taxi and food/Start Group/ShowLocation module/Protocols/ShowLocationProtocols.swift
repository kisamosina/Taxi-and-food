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
    
    func setupAddressEnterDetailLocationLabelText(_ text: String?)
}

protocol ShowLocationInteractorProtocol: class {
    
    var view: ShowLocationViewProtocol! { get }
    
    var addressEnterDetailViewType: AddressEnterDetailViewType { get }
    
    var addressString: String? { get set }
    
    init(view: ShowLocationViewProtocol, userLocation: CLLocationCoordinate2D?, addressEnterDetailViewType: AddressEnterDetailViewType)
    
    func getLocationRegion() -> MKCoordinateRegion?
}
