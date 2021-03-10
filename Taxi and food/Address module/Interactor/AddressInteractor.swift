//
//  AddressInteractor.swift
//  Taxi and food
//
//  Created by mac on 10/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol AddressInteractorProtocol: class {
    
    var view: AddressViewProtocol! { get }
    
    func sendAddressRequest()
}

class AddressInteractor: AddressInteractorProtocol {
    
    internal weak var view: AddressViewProtocol!
    private var addressResource: Resource<AddressResponse>
    private var addressResponse: AddressResponse!
    private let name: String?
    private let address: String?
    private let commentDriver: String?
    private let commentCourier: String?
    private let flat: Int?
    private let intercom: Int?
    private let entrance: Int?
    private let floor: Int?
    private let destination: Bool?
    
    required init(view: AddressViewProtocol, name: String?, address: String?, commentDriver: String?, commentCourier: String?, flat: Int?, intercom: Int?, entrance: Int?, floor: Int?, destination: Bool?) {
        
        self.view = view
        self.name = name
        self.address = address
        self.commentDriver = commentDriver
        self.commentCourier = commentCourier
        self.flat = flat
        self.intercom = intercom
        self.entrance = entrance
        self.floor = floor
        self.destination = destination
        
        self.addressResource = Resource<AddressResponse>(path: AddressRequestPaths.address.rawValue, requestType: .POST, requestData: [
            AddressRequestKeys.name.rawValue: name ?? "",
            AddressRequestKeys.address.rawValue: address ?? "",
            AddressRequestKeys.commentDriver.rawValue: commentDriver ?? "",
            AddressRequestKeys.commentCourier.rawValue: commentCourier ?? "",
            AddressRequestKeys.flat.rawValue: flat ?? 0,
            AddressRequestKeys.intercom.rawValue: intercom ?? 0,
            AddressRequestKeys.entrance.rawValue: entrance ?? 0,
            AddressRequestKeys.floor.rawValue: floor ?? 0,
            AddressRequestKeys.destination.rawValue: destination ?? true
            
        ])
    }
    
    func sendAddressRequest() {
        NetworkService.shared.makeRequest(for: addressResource) {[unowned self] result in
            
            switch result {
            case .success(let response):
                self.addressResponse = response
                print("RESPONSE DATA: \(self.addressResponse.data)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
     

    
}
