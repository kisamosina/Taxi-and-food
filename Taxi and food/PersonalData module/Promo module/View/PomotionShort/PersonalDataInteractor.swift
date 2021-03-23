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
    
//    var personalDataTableViewData:
    
    init(view: PersonalDataViewProtocol)
    
    func configure()
}

class PersonalDataInteractor: PersonalDataInteractorProtocol {
    
    var personalDataTableViewData: PersonalDataData!

    var models: [PersonalDataUISection] = [PersonalDataUISection]()
    
    internal weak var view: PersonalDataViewProtocol!
    
    required init(view: PersonalDataViewProtocol) {
        self.view = view
//        self.configureData()
    }
    
    func configure() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData(), let phoneNumber = userData[0].phoneNumber else { return }
        
        models.append(PersonalDataUISection(placeholder: "", options: [PersonalDataUIOption(title: "", text: PhoneFormatter().format(phone: phoneNumber), accessoryType: false)]))
        
        models.append(PersonalDataUISection(placeholder: PersonalDataViewControllerText.nameHeaderText, options: [PersonalDataUIOption(title: PersonalDataViewControllerText.nameTextFieldText, text: "", accessoryType: true)]))
        
        models.append(PersonalDataUISection(placeholder: PersonalDataViewControllerText.emailHeaderText, options: [PersonalDataUIOption(title: PersonalDataViewControllerText.emailTextFieldText, text: "", accessoryType: true)]))
        
    }
    
//    func configureData() {
//        
//                guard let userData = PersistanceStoreManager.shared.getUserData(), let phoneNumber = userData[0].phoneNumber else { return }
//        let cellPhoneData = PersonalDataData(imageName: CustomImagesNames.lkBlue.rawValue, name: PhoneFormatter().format(phone: phoneNumber))
//        
//        self.personalDataTableViewData = cellPhoneData
//        
//        
//    }
   
}
