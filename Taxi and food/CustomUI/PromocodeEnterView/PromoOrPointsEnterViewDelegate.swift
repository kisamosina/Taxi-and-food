//
//  PromocodeEnterViewDelegate.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoOrPointsEnterViewDelegate: class {
    
    func approveButtonDidTapped(for type: PromocodeEnterViewType, with text: String)
    func showSuccess()
    func setUpDescription(data: PromocodeDataResponse)
}
