//
//  PromocodeActivatingProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 29.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromocodeActivatingViewProtocol: AnyObject {
    
    var interactor: PromocodeActivatingInteractorProtocol { get }
    
    init(interactor: PromocodeActivatingInteractorProtocol)
    
    func promocodeActivated(description: String)
    
    func promocodeAlreadyActivated()
    
    func invalidPromocode()
}

protocol PromocodeActivatingInteractorProtocol: AnyObject {
    
    var view: PromocodeActivatingViewProtocol! { get set }
    
    func initView(_ view: PromocodeActivatingViewProtocol)
    
    func promocodeActivate(promocode: String)
}

protocol PromocodeActivatingViewControllerDelegate: AnyObject {
    func promocodeHasActivated(discount: Int)
}
