//
//  ISO8601DateFormatter+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}
