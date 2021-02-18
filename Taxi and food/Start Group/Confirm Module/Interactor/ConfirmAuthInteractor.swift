//
//  ConfirmAuthInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 13.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol ConfirmAuthInteractorProtocol: class {
    var view: ConfirmAuthViewProtocol! { get }
        
    init(view: ConfirmAuthViewProtocol, phoneNumber: String)
    
    func sendRegistrationRequest()
    func sendConfirmRequest(_ code: String)
}

class ConfirmAuthInteractor: ConfirmAuthInteractorProtocol {
    
    internal weak var view: ConfirmAuthViewProtocol!
            
    private var regResource: Resource<RegistrationResponse>
    private var regResponse: RegistrationResponse!
    private var confirmRespone: ConfirmResponse!
    private let phoneNumber: String
    
    required init(view: ConfirmAuthViewProtocol, phoneNumber: String) {
        self.view = view
        self.phoneNumber = phoneNumber
        self.regResource = Resource<RegistrationResponse>(path: RegistrationRequestPaths.registration.rawValue,
                                                          requestType: .POST,
                                                          requestData: [RegistrationRequestKeys.phone.rawValue: phoneNumber])
    }
    
    func sendRegistrationRequest() {
        NetworkService.shared.makeRequest(for: regResource) { result in
            
            switch result {
            
            case .success(let response):
                self.regResponse = response
                print("RESPONSE CODE: \(self.regResponse.data.code)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func sendConfirmRequest(_ code: String) {
        
        let confirmResource = Resource<ConfirmResponse>(path: RegistrationRequestPaths.confirm.rawValue,
                                                        requestType: .POST,
                                                        requestData: [RegistrationRequestKeys.phone.rawValue: phoneNumber,
                                                                      RegistrationRequestKeys.code.rawValue: code])
        
        NetworkService.shared.makeRequest(for: confirmResource) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let confirmResponse):
                print(confirmResponse)
                self.view.showMapViewController()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
