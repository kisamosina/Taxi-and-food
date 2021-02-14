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
    var topLabelText: String { get }
    var bottomLabelText: String { get }
    var userAgreementText: String { get }
    var isUserAgreementReceived: Bool { get set }
    var phoneFormatter: PhoneFormatter { get set }
    var nextButtonTitle: String { get }
    
    init (view: AuthViewProtocol)

}

class AuthInteractor: AuthInteractorProtocol {
        
    internal weak var view: AuthViewProtocol!
    
    var isUserAgreementReceived: Bool = false
    var phoneFormatter: PhoneFormatter = PhoneFormatter()
    
    var topLabelText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return AuthVCLabelsTexts.topLabelTextRus.rawValue
        case .en:
            return AuthVCLabelsTexts.topLabelTextEn.rawValue
        }
    }
    
    var bottomLabelText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return AuthVCLabelsTexts.bottomLabelTextRus.rawValue
        case .en:
            return AuthVCLabelsTexts.bottomLabelTextEn.rawValue
        }

    }
    
    var userAgreementText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return AuthVCLabelsTexts.userAgreementTextRus.rawValue
        case .en:
            return AuthVCLabelsTexts.userAgreementTextEn.rawValue
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
    
    required init(view: AuthViewProtocol) {
        self.view = view
    }
    
    
    
    
}
