//
//  PaymentWayNetworkServiceProtocol.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PaymentWayNetworkServiceProtocol {
    
    func getPaymentWayData(completion: @escaping(Result<[PaymentCardResponseData], Error>) -> Void)
}
