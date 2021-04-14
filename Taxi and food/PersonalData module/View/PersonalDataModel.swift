//
//  PersonalDataModel.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

struct PersonalDataUISection {
    let placeholder: String?
    let options: [PersonalDataUIOption]
}

struct PersonalDataUIOption {
    let title: String
    let text: String?
    let accessoryType: Bool
    let color: UIColor
}

struct PersonalDataData {
    var imageName: String? = nil
    var name: String
}
