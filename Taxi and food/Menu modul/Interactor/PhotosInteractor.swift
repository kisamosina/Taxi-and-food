//
//  ServiceInteractor.swift
//  Taxi and food
//
//  Created by mac on 15/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PhotosInteractorProtocol {
    var view: PhotosViewProtocol! { get }
    var selectImgeLabelText: String { get }
    var sendButtonText: String { get }
    
    init(view: PhotosInteractorProtocol)
}

class PhotosInteractor: PhotosInteractorProtocol {
    var view: PhotosViewProtocol!
    
    var selectImgeLabelText: String {
        
    }
    
    var sendButtonText: String
    
    required init(view: PhotosInteractorProtocol) {
        
    }
    
    
}
