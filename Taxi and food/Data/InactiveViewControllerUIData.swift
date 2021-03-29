//
//  InactiveViewControllerUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum InactiveViewControllerStates {
    
    case showPaymentHistoryDetailView
    case showOrderHistoryDetailView
    case showLogoutView
    case showPointsView(PointsResponseData)
    case showDeleteAddressView
    case showEnterPersonalDataView
    
}
