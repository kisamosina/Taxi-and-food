//
//  AuthInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 14.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol AuthInteractorProtocol {
    var view: AuthViewProtocol! { get }
    var isUserAgreementReceived: Bool { get set }
    var phoneFormatter: PhoneFormatter { get set }
        
    init (view: AuthViewProtocol)

}

class AuthInteractor: AuthInteractorProtocol {
        
    internal weak var view: AuthViewProtocol!
    
    var isUserAgreementReceived: Bool = false
    var phoneFormatter: PhoneFormatter = PhoneFormatter()
    
    
    required init(view: AuthViewProtocol) {
        self.view = view
    }
}
