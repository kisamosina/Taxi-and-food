//
//  WastePointsInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 30.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

import UIKit

class WastePointsInteractor: WastePointsInteractorProtocol {
    
    var credits: Int
    let orderSum: Double
    
    internal weak var view: WastePointsViewProtocol!

    required init(credits: Int, orderSum: Double) {
        self.credits = credits
        self.orderSum = orderSum
    }

    func initView(_ view: WastePointsViewProtocol) {
        self.view = view
    }
    
    func checkEnteredPointsWithCredits(points: Int) -> Bool {
        return points <= credits
    }
    
    func checkEnteredPointsWithOrderSum(points: Int) -> Bool {
        return points <= Int(orderSum.rounded())
    }
}
