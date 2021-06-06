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
    //MARK: - Saving user data
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
    
    //MARK: - Saving payment way
    
    func getSavedPaymentWay() -> [SavedPaymentWay]? {
                 
        let request: NSFetchRequest<SavedPaymentWay> = SavedPaymentWay.fetchRequest()
            
            do {
                let paymentWay = try context.fetch(request)
                return paymentWay
            } catch {
                print("Cannot read user data")
                return nil
            }
    }

    func deleteSavedPaymentWay() {
        guard let paymentWay = self.getSavedPaymentWay() else { return }
        paymentWay.forEach { self.context.delete($0) }

        self.save()

    }
    
    func savePaymentWay(id: Int?, title: String) {
        self.deleteSavedPaymentWay()
        let newPaymentWay = SavedPaymentWay(context: self.context)
        if let id = id {
            newPaymentWay.id = Int32(id)
        }
        newPaymentWay.title = title
        self.save()
    }
    
    //MARK: - Common
    
    
    //BE CAREFULL WHEN USE THIS FUNCTION DELETE ALL PERSISTANCE STORAGE DATA!!!!
    
    func deleteAllData() {
        self.deleteUserData()
        self.deleteSavedPaymentWay()
    }
    
    //Saving data
    
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
