//
//  ServerError.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct ServerErrors: Error {
    let statusCode: Int
}

enum ErrorCodes: Int {
    case wrongConfirmCode = 404
}

struct PersistanceStoreError: Error {
    let description: String
}
