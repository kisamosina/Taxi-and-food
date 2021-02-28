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

struct PromoShortData: Decodable {
    var id: Int
    var date_from: String?
    var date_to: String?
    var time_from: String?
    var time_to: String?
    var type: String?
    var title: String?
    var media: [PromoMedia]
}

struct PromoFullData: Decodable {
    
    var id: Int
    var date_from: String
    var date_to: String
    var time_from: String
    var time_to: String
    var type: String
    var title: String
    var description: String
  
}

struct PromoMedia: Decodable {
    var url: String?
    var file_name: String?
}



