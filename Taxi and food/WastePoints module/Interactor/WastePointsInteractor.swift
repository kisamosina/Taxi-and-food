//
//  WastePointsInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 30.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

import UIKit

class WastePointsInteractor: WastePointsInteractorProtocol {    
    
    internal weak var view: WastePointsViewProtocol!
    
    func initView(_ view: WastePointsViewProtocol) {
        self.view = view
    }
    
}
