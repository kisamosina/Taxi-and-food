//
//  TarifsPageViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TariffPageViewProtocol: class {
    var interactor: TariffPageInteractorProtocol! { get set }
    func setViewControllersFor(_ index: Int)
}

class TariffsPageViewController: UIPageViewController {
    
    internal var interactor: TariffPageInteractorProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        self.interactor = TariffPageInteractor(view: self)
    }
}

//MARK: - TariffsPageViewProtocol

extension TariffsPageViewController: TariffPageViewProtocol {
    
    func setViewControllersFor(_ index: Int) {
        
        DispatchQueue.main.async {
            if let tarifVC = self.interactor.showViewControllerAtIndex(index) {
                self.setViewControllers([tarifVC], direction: .forward, animated: true, completion: nil)
            }
        }
        
        
    }
}


extension TariffsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! TariffViewController).interactor.page
        pageNumber -= 1
        
        return interactor.showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! TariffViewController).interactor.page
        pageNumber += 1
        
        return interactor.showViewControllerAtIndex(pageNumber)
    }
    
    
}
