//
//  PersistanceStoreManager.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 22.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import CoreData

final class PersistanceStoreManager {
    
    static let shared = PersistanceStoreManager()
    private let context: NSManagedObjectContext
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func saveUserData(_ userData: ConfirmResponseData, phoneNumber: String) {
        DispatchQueue.global(qos: .background).async {
            self.deleteUserData()
            let newUserData = PersistanceUserData(context: self.context)
            newUserData.id = Int32(userData.id)
            newUserData.email = userData.email
            newUserData.name = userData.name
            newUserData.phoneNumber = phoneNumber
            self.save()
        }
    }
    
    func deleteUserData() {
        DispatchQueue.global(qos: .background).async {
            guard let userData = self.getUserData() else { return }
            userData.forEach { self.context.delete($0) }

            self.save()
        }
    }
    
    func getUserData() -> [PersistanceUserData]? {
                 
            let request: NSFetchRequest<PersistanceUserData> = PersistanceUserData.fetchRequest()
            
            do {
                let userData = try context.fetch(request)
                return userData
            } catch {
                print("Cannot read user data")
                return nil
            }
    }
    
    
    private func save() {
        DispatchQueue.main.async {
            do {
                try self.context.save()
            } catch {
                print("Error saving category \(error)")
            }

        }
                
    }
    
}
