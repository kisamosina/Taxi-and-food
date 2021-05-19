//
//  TranslatableTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol TranslatableTexts {
    static var lang: AppLanguages { get }
}

extension TranslatableTexts {
    
    static var lang: AppLanguages {
        UserDefaults.standard.getAppLanguage()
    }
}
