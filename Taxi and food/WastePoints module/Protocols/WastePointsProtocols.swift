//
//  WastePointsProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 30.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol WastePointsViewProtocol: AnyObject {
    
    var interactor: WastePointsInteractorProtocol { get }
    
    init(interactor: WastePointsInteractorProtocol)
    
}

protocol WastePointsInteractorProtocol: AnyObject {
    
    var view: WastePointsViewProtocol! { get set }
    
    func initView(_ view: WastePointsViewProtocol)
}
