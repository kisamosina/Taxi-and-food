//
//  TaxiHasFoundProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

protocol TaxiFoundViewProtocol: AnyObject {
    
    var interactor: TaxiFoundInteractorProtocol { get }
    
    init(interactor: TaxiFoundInteractorProtocol)
}


protocol TaxiFoundInteractorProtocol: AnyObject {
    
    var view: TaxiFoundViewProtocol! { get set }
    
    func initView(_ view: TaxiFoundViewProtocol)
}


protocol TaxiFoundViewControllerDelegate: AnyObject {
    
}
