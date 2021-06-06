//
//  CancelAnOrderServiceProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 31.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol CancelAnOrderNetworkServiceProtocol {
    func makeCancelationOrderRequest(reason: String, completion: @escaping(Result<EmptyResponseModel, Error>) -> Void)
}
