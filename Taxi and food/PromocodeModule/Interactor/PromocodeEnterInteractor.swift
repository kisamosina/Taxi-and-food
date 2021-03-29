//
//  PromocodeEnterInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromocodeEnterInteractorProtocol: class {
    var view: PromocodeEnterViewProtocol! { get }
    
    init(view: PromocodeEnterViewProtocol)
    
    func requestPromocodeActivate(code: String)

}

class PromocodeEnterInteractor: PromocodeEnterInteractorProtocol {
    
    internal weak var view: PromocodeEnterViewProtocol!
    
    required init(view: PromocodeEnterViewProtocol) {
        self.view = view
    }
    
    func requestPromocodeActivate(code: String) {
        guard let id = PersistanceStoreManager.shared.getUserData()?[0].id
        else {
            print("No user id in storage")
            return
            
        }
        
        let promocodeResource = Resource<PromocodeResponse>(path: PromocodesRequestPaths.activate.rawValue.getServerPath(for: Int(id)),
                                                          requestType: .POST,
                                                          requestData: [PromocodesRequestKeys.code.rawValue: code])

        NetworkService.shared.makeRequest(for: promocodeResource, completion:  { result in
        
            switch result {
            
            case .success(let promocodeResponse):
                self.view.showSuccess(data: promocodeResponse.data)
            case .failure(let error):
                if let serverError = error as? ServerErrors {
                    switch serverError.statusCode {
                     case 403:
                        self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.promocodeAlreadyHas)
                        
                    default:
                        self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.invalidPromocode)
                    }
                }
            }
        })

    }
    
}


