//
//  PersonalAccountTableViewModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PersonalAccountTableViewModel {
    var cellsData: [PersonalAccountTableViewCellModel]
}

struct PersonalAccountTableViewCellModel {
    var imageName: String? = nil
    var name: String
}

