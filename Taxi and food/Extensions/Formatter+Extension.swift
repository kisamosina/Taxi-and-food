//
//  Formatter+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}
