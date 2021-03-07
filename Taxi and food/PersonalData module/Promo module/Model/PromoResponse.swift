//
//  PromoResponse.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PromoResponse: Decodable {
    var data: [PromoShortData]
}

struct PromoResponseFull: Decodable {
    var data: PromoFullData
}

struct PromoShortData: Decodable {

    var id: Int
    var dateFrom: String?
    var dateTo: String?
    var timeFrom: String?
    var timeTo: String?
    var type: String?
    var title: String?
    var media: [PromoMedia]
    
}

struct PromoFullData: Decodable {
    
    var id: Int?
    var dateFrom: String?
    var dateTo: String?
    var timeFrom: String?
    var timeTo: String?
    var type: String?
    var title: String?
    var description: String?
    var media: [PromoMedia]
  
}

struct PromoMedia: Decodable {
    var url: String?
    
}





