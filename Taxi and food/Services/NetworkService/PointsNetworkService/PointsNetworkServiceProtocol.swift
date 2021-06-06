//
//  PointsNetworkServiceProtocol.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PointsNetworkServiceProtocol {
    func getPoints(completion: @escaping (Result<PointsResponseData,Error>) -> Void)
}
