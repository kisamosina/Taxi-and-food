//
//  TariffsPageInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TariffPageInteractorProtocol: AnyObject {
    
    var view: TariffPageViewProtocol! { get set }
    var tariffs: [TariffData] { get set }
    
    init(view: TariffPageViewProtocol, tariffs: [TariffData])
    
    func showViewControllerAtIndex(_ index: Int) -> TariffViewController?
    func getViewControllerForTitle(_ title: String)
}

class TariffPageInteractor: TariffPageInteractorProtocol {
    
    internal weak var view: TariffPageViewProtocol!
    var tariffs: [TariffData] = []
    private var tariffsNames: [String] {
        return self.tariffs.map{ $0.name }
    }
    

    
    required init(view: TariffPageViewProtocol, tariffs: [TariffData]) {
        self.view = view
        self.tariffs = tariffs
        self.view.setViewControllerFor(0)

    }
        
    func showViewControllerAtIndex(_ index: Int) -> TariffViewController? {
        
        guard index >= 0 && index < tariffs.count else { return nil }
        let storyboard = UIStoryboard.init(name: StoryBoards.Tarifs.rawValue, bundle: nil)
        guard let tariffViewController = storyboard.instantiateViewController(
                withIdentifier: ViewControllers.TariffViewController.rawValue) as? TariffViewController else { return nil }
        
        tariffViewController.interactor = TariffInteractor(view: tariffViewController, tariff: tariffs[index], tariffsNames: self.tariffsNames, page: index)
        
        
        return tariffViewController
    }
    
    func getViewControllerForTitle(_ title: String) {
        guard let index  = tariffsNames.firstIndex(of: title) else { return }
        self.view.setViewControllerFor(index)
    }
    
}
