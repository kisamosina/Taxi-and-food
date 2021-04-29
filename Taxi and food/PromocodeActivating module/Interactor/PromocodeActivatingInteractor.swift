//
//  PromocodeActivatingInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 29.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

class PromocodeActivatingInteractor: PromocodeActivatingInteractorProtocol {
    
    weak var view: PromocodeActivatingViewProtocol!
    
    func initView(_ view: PromocodeActivatingViewProtocol) {
        self.view = view
    }
    
}
