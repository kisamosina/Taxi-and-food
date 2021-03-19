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

enum PromocodesRequestPaths: String {
    case activate = "user/$/promo-codes/activate"
    case getHistory = "user/$/promo-codes"
}

enum PromocodesRequestKeys: String {
    case code
}

enum PaymentRequestPaths: String {
    case history = "user/$/history/payments"
    case paymentCards = "user/$/payment-cards"
    case points = "user/$/credit"
}

enum NewPaymentCardRequestPaths: String {
    case paymentCard = "user/$/payment-card"
    case approveCard = "user/$/payment-card/@/approved"
}

enum NewPaymentCardRequestKeys: String {
    case number
    case expiryDate = "expiry_date"
    case cvc
}


//FIX: - fix id to $

enum AddressRequestPaths: String {
    case addressPostAndGet = "user/$/address"
    case addressPutAndDelete = "user/$/address/$"
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

