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
    var topLabelText: String { get }
    var nextButtonTitle: String { get }
    var resendText: String { get }
    
    init(view: ConfirmAuthViewProtocol, phoneNumber: String)
    
    func sendRegistrationRequest()
    func sendConfirmRequest()
}

class ConfirmAuthInteractor: ConfirmAuthInteractorProtocol {
    
    internal weak var view: ConfirmAuthViewProtocol!
    
    var topLabelText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return ConfirmAuthVCLabelsTexts.topLabelRus.rawValue
        case .en:
            return ConfirmAuthVCLabelsTexts.topLabelEn.rawValue
        }
    }
    
    var nextButtonTitle: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return AuthVCButtonsTexts.nextButtonTitleRus.rawValue
        case .en:
            return AuthVCButtonsTexts.nextButtonTitleEn.rawValue
        }
    }
    
    var resendText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return ConfirmAuthVCLabelsTexts.resendTextRus.rawValue
        case .en:
            return ConfirmAuthVCLabelsTexts.resendTextRus.rawValue
        }
    }
    
    var regResource: Resource<RegistrationResponse>
    var confirmResource: Resource<ConfirmResponse>
    var regRequest: RegistrationRequest
    var confirmRequest: ConfirmRequest!
    
    required init(view: ConfirmAuthViewProtocol, phoneNumber: String) {
        self.view = view
        self.regRequest = RegistrationRequest(phone: phoneNumber)
        self.regResource = Resource<RegistrationResponse>(path: "auth/registration", requestType: .POST)
        self.confirmResource = Resource<ConfirmResponse>(path: "auth/confirm", requestType: .POST)
    }
    
    func sendRegistrationRequest() {
        NetworkService.shared.makeRequest(for: regResource, data: regRequest) { result in
            
            switch result {
            
            case .success(let regResponse):
                print(regResponse)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func sendConfirmRequest() {
        NetworkService.shared.makeRequest(for: confirmResource, data: confirmRequest) { result in
            
            switch result {
            
            case .success(let confirmResponse):
                print(confirmResponse)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
