//
//  SettingsOption.swift
//  Taxi and food
//
//  Created by mac on 18/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct Section {
    let tittle: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsOption {
    
    let title: String
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    let handler: (() -> Void)
    var isOn: Bool
    
}

