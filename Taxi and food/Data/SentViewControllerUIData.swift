//
//  SentViewControllerUIData.swift
//  Taxi and food
//
//  Created by mac on 16/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct SentViewControllerTextData {
    
    internal enum RusLabelsTexts: String {
        case selectImgeLabelTextRu = "Обращение отправлено"
        case messageSentLabelTextRu = "В течении часа с вами свяжется наш менеджер и постарается решить вашу проблему."
        
    }
    internal enum EngLabelTexts: String {
        case selectImgeLabelTextEn = "Your appeal has been sent"
        case messageSentLabelTextEn = "Within an hour, our manager will contact you and try to solve your problem."
    
    }
    internal enum RusButtonTexts: String {
        case sendButtonTextRu = "Отлично!"
        
    }
    
    internal enum EngButtonTexts: String {
        case sendButtonTextEn = "Done!"
        
    }
}
