//
//  NewCardEnterProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation


protocol NewCardEnterViewProtocol: class {
    var interactor: NewCardEnterInteractorProtocol! { get set }
}


protocol NewCardEnterInteractorProtocol: class {
    
    var view: NewCardEnterViewProtocol! { get }
    
    init(view: NewCardEnterViewProtocol)
    
    func makeRequestFor(cardNumber: String, expirationDate: String, cvv: String)
}
