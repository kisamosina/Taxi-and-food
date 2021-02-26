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
    var models: [PersonalDataSection] { get set }
    
    init(view: PersonalDataViewProtocol)
    
    func configure()
}

class PersonalDataInteractor: PersonalDataInteractorProtocol {

    var models: [PersonalDataSection] = [PersonalDataSection]()
    
    internal weak var view: PersonalDataViewProtocol!
    
    required init(view: PersonalDataViewProtocol) {
        self.view = view
    }
    
    func configure() {
        models.append(PersonalDataSection(tittle: "", options: [PersonalDataOption(title: "")]))
        
        models.append(PersonalDataSection(tittle: PersonalDataViewControllerText.nameHeaderText, options: [PersonalDataOption(title: PersonalDataViewControllerText.nameTextFieldText)]))
        
        models.append(PersonalDataSection(tittle: PersonalDataViewControllerText.emailHeaderText, options: [PersonalDataOption(title: PersonalDataViewControllerText.emailTextFieldText)]))
        
    }
   
}
