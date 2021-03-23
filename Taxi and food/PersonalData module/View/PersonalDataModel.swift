//
//  PersonalDataModel.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PersonalDataUISection {
    let placeholder: String?
    let options: [PersonalDataUIOption]
}

struct PersonalDataUIOption {
    let title: String
    let text: String?
    let accessoryType: Bool
}

struct PersonalDataData {
    var imageName: String? = nil
    var name: String
}
