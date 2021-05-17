//
//  WastePointsProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 30.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol WastePointsViewProtocol: AnyObject {
    
    var interactor: WastePointsInteractorProtocol { get }
    
    init(interactor: WastePointsInteractorProtocol)
    
}

protocol WastePointsInteractorProtocol: AnyObject {
    
    var view: WastePointsViewProtocol! { get set }
    
    var credits: Int { get set }
    
    var orderSum: Double { get }
    
    init(credits: Int, orderSum: Double)
    
    func initView(_ view: WastePointsViewProtocol)
    
    func checkEnteredPointsWithCredits(points: Int) -> Bool
    
    func checkEnteredPointsWithOrderSum(points: Int) -> Bool
}

protocol WastePointsViewControllerDelegate: AnyObject {
    func waste(points: Int)
}
