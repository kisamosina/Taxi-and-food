//
//  PhotosViewControllerUIData.swift
//  Taxi and food
//
//  Created by mac on 16/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PhotosViewControllerTextData {

    internal enum RusLabelsTexts: String {
        case selectImgeLabelTextRu = "При необходимости прикрепите изображения"
        case countImagesTextRu = "Вы прикрепили максимальное количество фото (10)"
}
    internal enum EngLabelTexts: String {
        case selectImgeLabelTextEn = "Attach images if necessary"
        case countImagesTextEn = "You have attached the maximum number of photos (10)"
    
    }
    
    internal enum RusButtonTexts: String {
        case sendButtonTextRu = "Отправить"
        
    }
    
    internal enum EngButtonTexts: String {
        case sendButtonTextEn = "Send"
        
    }
    
    
    static var selectImgeLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusLabelsTexts.selectImgeLabelTextRu.rawValue
        case .eng:
            return EngLabelTexts.selectImgeLabelTextEn.rawValue
        }
    }
    
    static var countImagesText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusLabelsTexts.countImagesTextRu.rawValue
        case .eng:
            return EngLabelTexts.countImagesTextEn.rawValue
        }
    }
    
    static var ButtonText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusButtonTexts.sendButtonTextRu.rawValue
        case .eng:
            return EngButtonTexts.sendButtonTextEn.rawValue
        }
    }
}
