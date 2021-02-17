//
//  TarifInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol TariffInteractorProtocol: class {
    var view: TariffViewProtocol? { get }
    var tariffAdvantages: [TariffAdvantage] { get set }
    
    init(view: TariffViewProtocol)
    
    func getTarifs()
}

class TariffInteractor: TariffInteractorProtocol {
    
    internal weak var view: TariffViewProtocol?
    
    var tariffAdvantages: [TariffAdvantage] = []
    
    required init(view: TariffViewProtocol) {
        self.view = view
    }
    
        
    func getTarifs() {
        let resource = Resource<TariffResponse>(path: "user/75/tariff", requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, data: TariffRequest()) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.present(tariffResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func present(_ tariffResponse: TariffResponse) {
        let tariff = tariffResponse.data[0]
        self.tariffAdvantages = tariff.advantages
        self.view?.setViewsData(tariff)
    }
}
