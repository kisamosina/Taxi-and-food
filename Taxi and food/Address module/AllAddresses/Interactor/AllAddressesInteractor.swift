//
//  AllAddressesInteractor.swift
//  Taxi and food
//
//  Created by mac on 11/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol AllAddressesInteractorProtocol: class {
    var view: AllAddressesViewProtocol! { get }
    
    var arrayOfAddresses: [AddressResponseData]? { get set }
    var address: AddressResponseData? { get }
    
    func getAllAddresses()
}

class AllAddressesInteractor: AllAddressesInteractorProtocol {
    
    var view: AllAddressesViewProtocol!
    
    var arrayOfAddresses: [AddressResponseData]?
    var address: AddressResponseData?
    
    required init(view: AllAddressesViewProtocol) {
        self.view = view
    }
    
    func getAllAddresses() {
        
        let path = AddressRequestPaths.addressPostAndGet.rawValue.getServerAddressPath(for: 1)
        let resource = Resource<AddressResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let addressResponse):
                print("my all data")
                print(addressResponse.data)
//                self.arrayOfAddresses = addressResponse.data
                self.view.cellModel = addressResponse.data
                self.view.updateTableViewData()
            
            case .failure(let error):
               print(error.localizedDescription)
                
            }
        }
 
    }
    
    
}
