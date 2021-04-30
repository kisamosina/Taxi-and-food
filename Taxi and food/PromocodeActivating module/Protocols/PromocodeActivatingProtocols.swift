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
    
}

protocol PromocodeActivatingInteractorProtocol: AnyObject {
    
    var view: PromocodeActivatingViewProtocol! { get set }
    
    func initView(_ view: PromocodeActivatingViewProtocol)
}
