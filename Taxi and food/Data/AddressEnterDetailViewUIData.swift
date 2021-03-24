//
//  AddressEnterDetailViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum AddressEnterDetailViewStringData: String {
    case nibName = "AddressEnterDetailView"
}

enum AddressEnterDetailViewSizes: CGFloat {
    case height = 230
}

enum AddressEnterDetailViewType {
    case addressFrom
    case addressTo
    case showDestination(String?)
}

struct AddressesEnterDetailViewTexts {
    
    private enum RusTexts: String {
        case locationFromTextFieldPlaceholder = "Уточните, как до вас добраться"
        case locationToTextFieldPlaceholder = "Уточните, куда едем"
    }
    
    private enum EngTexts: String {
        case locationFromTextFieldPlaceholder = "Please write how to get to you"
        case locationToTextFieldPlaceholder = "Please write where we will go"
    }
    
    static var locationFromTextFieldPlaceholder: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.locationFromTextFieldPlaceholder.rawValue
        case .eng:
            return EngTexts.locationFromTextFieldPlaceholder.rawValue
        }
    }
    
    static var locationToTextFieldPlaceholder: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.locationToTextFieldPlaceholder.rawValue
        case .eng:
            return EngTexts.locationToTextFieldPlaceholder.rawValue
        }
    }

}
