//
//  NetworkRequestData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum RegistrationRequestPaths: String {
    case registration = "auth/registration"
    case confirm = "auth/confirm"
   
}

enum RegistrationRequestKeys: String {
    case phone
    case code
   
}

//FIX: - fix id to $

enum AddressRequestPaths: String {
    case address = "user/$/address"
    
}

enum AddressRequestKeys: String {
    case name
    case address
    case comment_driver
    case comment_courier
    case flat
    case intercom
    case entrance
    case floor
    case destination
    
}

