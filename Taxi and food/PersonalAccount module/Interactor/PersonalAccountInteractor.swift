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
    var paymentCards: [PaymentCardResponseData] = []
    
    required init(view: PersonalAccountViewProtocol) {
        self.view = view
        self.setPersonalAccountTableViewData()
        self.getPaymentData()
    }
    
    private func setPersonalAccountTableViewData() {
       
        guard let userData = PersistanceStoreManager.shared.getUserData(), let phoneNumber = userData[0].phoneNumber else { return }
        
        let cellPhoneData = PersonalAccountTableViewCellModel(imageName: CustomImagesNames.lkBlue.rawValue, name: PhoneFormatter().format(phone: phoneNumber))
        
        let firstSection = [cellPhoneData] + PersonalAccountViewControllerTexts.tableViewTextData.filter { $0 == PersonalAccountViewControllerTexts.myAddresses }.map({ PersonalAccountTableViewCellModel(name: $0)})
        
        let secondSection = PersonalAccountViewControllerTexts.tableViewTextData.filter { $0 != PersonalAccountViewControllerTexts.myAddresses }.map({[weak self] in
                                                                                                                                                        PersonalAccountTableViewCellModel(imageName: self?.setPaymentWayIconName(title: $0), name: $0)})
        
        
        self.personalAccountTableViewData = [ PersonalAccountTableViewModel(cellsData: firstSection),
                                             PersonalAccountTableViewModel(cellsData: secondSection)]

    }
    
    //Set icon name for payment way
    
    private func setPaymentWayIconName(title: String) -> String? {
        guard title == PersonalAccountViewControllerTexts.paymentWay else  { return nil }
        if self.paymentCards.isEmpty {
            return CustomImagesNames.paymentWayOne.rawValue
        }
        return nil
    }
    
    func getPaymentData() {
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PaymentResponse>(path: PaymentRequestPaths.paymentCards.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] paymentResponse in
            guard let self = self else { return }
            
            switch paymentResponse {
            
            case .success(let paymentResponse):
                
                self.paymentCards = paymentResponse.data
                self.setPersonalAccountTableViewData()
                self.view.reloadTableViewData()
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        })
    }
    
}
