//
//  PersonalDataInteractor.swift
//  Taxi and food
//
//  Created by mac on 26/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PersonalDataInteractorProtocol {
    var view: PersonalDataViewProtocol! { get }
    var models: [PersonalDataUISection] { get set }
    var personalDataTableViewData: PersonalDataData! { get set }
    init(view: PersonalDataViewProtocol)
    
    func configure()
}

class PersonalDataInteractor: PersonalDataInteractorProtocol {
    
    var personalDataTableViewData: PersonalDataData!

    var models: [PersonalDataUISection] = [PersonalDataUISection]()
    
    internal weak var view: PersonalDataViewProtocol!
    
    required init(view: PersonalDataViewProtocol) {
        self.view = view

    }
    
    func configure() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData(), let phoneNumber = userData[0].phoneNumber else { return }
    
        models.append(PersonalDataUISection(placeholder: " ", options: [PersonalDataUIOption(title: PhoneFormatter().format(phone: phoneNumber), text: "", accessoryType: false, key: "phone")]))
        
        models.append(PersonalDataUISection(placeholder: PersonalDataViewControllerText.nameHeaderText, options: [PersonalDataUIOption(title: PersonalDataViewControllerText.nameTextFieldText, text: "", accessoryType: true, key: "name")]))
        
        models.append(PersonalDataUISection(placeholder: PersonalDataViewControllerText.emailHeaderText, options: [PersonalDataUIOption(title: PersonalDataViewControllerText.emailTextFieldText, text: "", accessoryType: true, key: "email")]))
        
    }

   
}
