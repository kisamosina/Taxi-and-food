//
//  PersonalAccountInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PersonalAccountInteractor: PersonalAccountInteractorProtocol {
    
    weak internal var view: PersonalAccountViewProtocol!
    var personalAccountTableViewData: [PersonalAccountTableViewModel]!
    
    required init(view: PersonalAccountViewProtocol) {
        self.view = view
        self.setPersonalAccountTableViewData()
    }
    
    private func setPersonalAccountTableViewData() {
       
        guard let userData = PersistanceStoreManager.shared.getUserData(), let phoneNumber = userData[0].phoneNumber else { return }
        
        let cellPhoneData = PersonalAccountTableViewCellModel(imageName: CustomImagesNames.lkBlue.rawValue, name: PhoneFormatter().format(phone: phoneNumber))
        
        let firstSection = [cellPhoneData] + PersonalAccountViewControllerTexts.tableViewTextData.filter { $0 == PersonalAccountViewControllerTexts.myAddresses }.map({ PersonalAccountTableViewCellModel(name: $0)})
        let secondSection = PersonalAccountViewControllerTexts.tableViewTextData.filter { $0 != PersonalAccountViewControllerTexts.myAddresses }.map({ PersonalAccountTableViewCellModel(name: $0)})
        self.personalAccountTableViewData = [ PersonalAccountTableViewModel(cellsData: firstSection),
                                             PersonalAccountTableViewModel(cellsData: secondSection)]
    }
    
}
