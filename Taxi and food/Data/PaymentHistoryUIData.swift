//
//  PaymentHistoryUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

struct PaymentHistoryViewControllerTexts {
    
    private enum RusTexts: String {
        case emptyLabelText = "Здесь пока пусто..."
    }
    
    private enum EngTexts: String {
        case emptyLabelText = "It's empty here for now..."
    }
    
    static var emptyLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.emptyLabelText.rawValue
        case .eng:
            return EngTexts.emptyLabelText.rawValue
        }
    }
    
}

enum PaymentHistoryCellViewLayer: CGFloat {
    case shadowOpacity = 1
    case shadowRadius = 10
    case shadowOffsetHeightAndWidth = 1.01
}

enum PaymentHistoryCellTexts: String {
    case id = "PromocodeHistoryTableViewCell"
}
