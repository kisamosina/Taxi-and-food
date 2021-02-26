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
    func setViewControllerFor(_ index: Int)
}

class TariffsPageViewController: UIPageViewController {
    
    internal var interactor: TariffPageInteractorProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.title = TariffViewControllerTextData.navBarTtitle
    }
}


//MARK: - TariffsPageViewProtocol

extension TariffsPageViewController: TariffPageViewProtocol {
    
    func setViewControllerFor(_ index: Int) {
        
        DispatchQueue.main.async {
            if let tarifVC = self.interactor.showViewControllerAtIndex(index) {
                tarifVC.tariffPageDelegate = self
                self.setViewControllers([tarifVC], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}


extension TariffsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let tariffVC = viewController as? TariffViewController else { return UIViewController() }
        var pageNumber = tariffVC.interactor.page
        tariffVC.tariffPageDelegate = self
        pageNumber -= 1
        
        return interactor.showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let tariffVC = viewController as? TariffViewController else { return UIViewController() }
        var pageNumber = tariffVC.interactor.page
        tariffVC.tariffPageDelegate = self
        pageNumber += 1
        
        return interactor.showViewControllerAtIndex(pageNumber)
    }
    
}

extension TariffsPageViewController: TariffPageViewControllerDelegate {
    func setVC(for tariffName: String) {
        interactor.getViewControllerForTitle(tariffName)
    }
}
