//
//  PromocodeActivatingProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 29.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromocodeActivatingViewProtocol: class {
    
    var interactor: PromocodeActivatingInteractorProtocol { get }
    
    init(interactor: PromocodeActivatingInteractorProtocol)
    
}

protocol PromocodeActivatingInteractorProtocol: class {
    
    var view: PromocodeActivatingViewProtocol! { get set }
    
    func initView(_ view: PromocodeActivatingViewProtocol)
}
