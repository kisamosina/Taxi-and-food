//
//  AddressInteractor.swift
//  Taxi and food
//
//  Created by mac on 10/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol AddressInteractorProtocol: AnyObject {
    
    var view: AddressViewProtocol! { get }
    
    func sendAddressRequest(name: String?, address: String?, commentDriver: String?, commentCourier: String?, flat: Int?, intercom: Int?, entrance: Int?, floor: Int?, destination: Bool?)
    
    func deleteAddress(with addressId: Int)
    
    func changeAddress(with addressId: Int, with data: [String: Any]?)
}

class AddressInteractor: AddressInteractorProtocol {

    internal weak var view: AddressViewProtocol!

    private var addressResponse: AddressResponse!

    
    required init(view: AddressViewProtocol) {
        
        self.view = view
        
    }
    
    func sendAddressRequest(name: String?, address: String?, commentDriver: String?, commentCourier: String?, flat: Int?, intercom: Int?, entrance: Int?, floor: Int?, destination: Bool?) {
        
//Uncomment if start from main screen
        
//        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
//        let path = AddressRequestPaths.addressPostAndGet.rawValue.getServerPath(for: Int(user.id))
        
        let path = AddressRequestPaths.addressPostAndGet.rawValue.getServerAddressPath(for: 3)
        let data: [String: Any] = [
                 AddressRequestKeys.name.rawValue: name ?? "",
                 AddressRequestKeys.address.rawValue: address ?? "",
                 AddressRequestKeys.comment_driver.rawValue: commentDriver ?? "",
                 AddressRequestKeys.comment_courier.rawValue: commentCourier ?? "",
                 AddressRequestKeys.flat.rawValue: flat ?? 0,
                 AddressRequestKeys.intercom.rawValue: intercom ?? 0,
                 AddressRequestKeys.entrance.rawValue: entrance ?? 0,
                 AddressRequestKeys.floor.rawValue: floor ?? 0,
                 AddressRequestKeys.destination.rawValue: destination ?? true
        
             ]
        
        let addressResource = Resource<AddressResponse>(path: path, requestType: .POST, requestData: data)
       
        NetworkService.shared.makeRequest(for: addressResource, completion:  { result in
            
            switch result {
            case .success(let response):
                self.addressResponse = response
                print("RESPONSE DATA: \(self.addressResponse.data)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
        
    }
    
    func deleteAddress(with addressId: Int) {
        
        //Uncomment if start from main screen
                
        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = AddressRequestPaths.addressPutAndDelete.rawValue.getServerAddressPath(for: Int(user.id), for: addressId)
        
        let addressResource = Resource<AddressResponse>(path: path, requestType: .DELETE)
        
        NetworkService.shared.makeRequest(for: addressResource, completion:  { result in
            
            switch result {
            case .success:
                print("DELETED")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
        
    }
    
    
    func changeAddress(with addressId: Int, with data: [String: Any]?) {
        
        //Uncomment if start from main screen
                
        //        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        //        let path = AddressRequestPaths.address.rawValue.getServerPathforAddress(for: Int(user.id))
        
        let path = AddressRequestPaths.addressPutAndDelete.rawValue.getServerAddressPath(for: 3, for: addressId)
        
        let addressResource = Resource<AddressResponse>(path: path, requestType: .PUT, requestData: data)
        
        NetworkService.shared.makeRequest(for: addressResource, completion:  {[unowned self] result in
            
            switch result {
            case .success:
                print("RESPONSE DATA: \(self.addressResponse.data)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
}
