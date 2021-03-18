//
//  UIAlertController+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func showLocationSettingsAlert(title: String, message: String) -> UIAlertController {
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: AlertControllerTexts.settingsText, style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: AlertControllerTexts.cancelText, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        return alertController
    }
}
