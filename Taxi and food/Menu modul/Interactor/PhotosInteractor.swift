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
    
    
    init(view: PhotosInteractorProtocol)
}

class PhotosInteractor: PhotosInteractorProtocol {
  
    
    var view: PhotosViewProtocol!
    
   
    
    required init(view: PhotosInteractorProtocol) {
        self.view = view as! PhotosViewProtocol
        
    }
    
    
}
