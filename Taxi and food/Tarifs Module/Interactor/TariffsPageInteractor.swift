//
//  TariffsPageInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TariffPageInteractorProtocol: class {
    
    var view: TariffPageViewProtocol! { get set }
    var tariffs: [TariffData] { get set }
    
    init(view: TariffPageViewProtocol)
    
    func getTarifs()
    func showViewControllerAtIndex(_ index: Int) -> TariffViewController?
    
}

class TariffPageInteractor: TariffPageInteractorProtocol {
    
    internal weak var view: TariffPageViewProtocol!
    var tariffs: [TariffData] = []
    

    
    required init(view: TariffPageViewProtocol) {
        self.view = view
        getTarifs()
    }
    
    func getTarifs() {
        
        let resource = Resource<TariffResponse>(path: "user/75/tariff", requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, data: TariffRequest()) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.tariffs = tariffResponse.data
                self.view.setViewControllersFor(0)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> TariffViewController? {
        
        guard index >= 0 && index < tariffs.count else { return nil }
        let storyboard = UIStoryboard.init(name: StoryBoards.Tarifs.rawValue, bundle: nil)
        guard let tariffViewController = storyboard.instantiateViewController(
                withIdentifier: ViewControllers.TariffViewController.rawValue) as? TariffViewController else { return nil }
        
        tariffViewController.interactor = TariffInteractor(view: tariffViewController, tariff: tariffs[index], page: index)
        
        
        return tariffViewController
    }

    
    
}
