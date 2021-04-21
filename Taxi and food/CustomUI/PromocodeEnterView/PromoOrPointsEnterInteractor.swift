//
//  PromoOrPointsInteractor.swift
//  Taxi and food
//
//  Created by mac on 20/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromoOrPointsEnterViewInteractorProtocol: class {
    
    var view: PromoOrPointsEnterViewProtocol! { get }
    
    func requestPromoActivation(code: String)
}

class PromoOrPointsEnterViewInteractor: PromoOrPointsEnterViewInteractorProtocol {
    
    //MARK: - Initializer
    
    required init(view: PromoOrPointsEnterView) {
        self.view = view
    }
    
   
    var view: PromoOrPointsEnterViewProtocol!
    
    func requestPromoActivation(code: String) {
//            guard let id = PersistanceStoreManager.shared.getUserData()?[0].id
//            else {
//                print("No user id in storage")
//                return
//
//            }
        let id = 1
            
            let promocodeResource = Resource<PromocodeResponse>(path: PromocodesRequestPaths.activate.rawValue.getServerPath(for: Int(id)),
                                                              requestType: .POST,
                                                              requestData: [PromocodesRequestKeys.code.rawValue: code])

            NetworkService.shared.makeRequest(for: promocodeResource, completion:  { result in
            
                switch result {
                
                case .success(let promocodeResponse):
                    self.view.showPromoSuccess(data: promocodeResponse.data)
                    print("successfulActivation")
                    
                case .failure(let error):
                    if let serverError = error as? ServerErrors {
                        switch serverError.statusCode {
                         case 403:
                            self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.promocodeAlreadyHas)
                            print("unsuccessfulActivation")
                            
                        default:
                            self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.invalidPromocode)
                            print("invalid")
                        }
                    }
                }
            })

        }
}
