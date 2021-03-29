//
//  ConfirmAuthInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 13.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import UserNotifications

protocol ConfirmAuthInteractorProtocol: class {
    var view: ConfirmAuthViewProtocol! { get }
    
    init(view: ConfirmAuthViewProtocol, phoneNumber: String)
    
    func sendRegistrationRequest()
    func sendConfirmRequest(_ code: String)
}

class ConfirmAuthInteractor: ConfirmAuthInteractorProtocol {
    
    internal weak var view: ConfirmAuthViewProtocol!
    
    private var regResource: Resource<RegistrationResponse>
    private var regResponse: RegistrationResponse!
    private var confirmRespone: ConfirmResponse!
    private let phoneNumber: String
    
    required init(view: ConfirmAuthViewProtocol, phoneNumber: String) {
        self.view = view
        self.phoneNumber = phoneNumber
        self.regResource = Resource<RegistrationResponse>(path: RegistrationRequestPaths.registration.rawValue,
                                                          requestType: .POST,
                                                          requestData: [RegistrationRequestKeys.phone.rawValue: phoneNumber])
    }
    
    func sendRegistrationRequest() {
        NetworkService.shared.makeRequest(for: regResource, completion: {[unowned self] result in
            
            switch result {
            
            case .success(let response):
                self.regResponse = response
                print("RESPONSE CODE: \(self.regResponse.data.code)")
                self.scheduleNotification(with: self.regResponse.data.code)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
    }
    
    func sendConfirmRequest(_ code: String) {
        
        let confirmResource = Resource<ConfirmResponse>(path: RegistrationRequestPaths.confirm.rawValue,
                                                        requestType: .POST,
                                                        requestData: [RegistrationRequestKeys.phone.rawValue: phoneNumber,
                                                                      RegistrationRequestKeys.code.rawValue: code])
        
        NetworkService.shared.makeRequest(for: confirmResource, completion: {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let confirmResponse):
                DispatchQueue.main.async {
                    PersistanceStoreManager.shared.saveUserData(confirmResponse.data, phoneNumber: self.phoneNumber)
                }
                self.view.showMapViewController()
            case .failure(let error):
                print(error)
                guard let serverError = error as? ServerErrors, serverError.statusCode == ErrorCodes.wrongConfirmCode.rawValue else { return }
                self.view.setupWhenError()
            }
        })
        
    }
    
    private func scheduleNotification(with code: Int) {
        let content = UNMutableNotificationContent()
        content.title = ConfirmAuthViewControllerTexts.pushConfirmationTitle
        content.body = ConfirmAuthViewControllerTexts.pushConfirmationBody + "\(code)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = NotificationsIdentifiers.confirmtaionCode.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.notificationCenter.add(request) { error in
                if let error = error {
                    print("Notification error: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
}
