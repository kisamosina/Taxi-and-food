//
//  LanguageViewController.swift
//  Taxi and food
//
//  Created by mac on 19/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    var models = [LanguageOption]()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        configure()

        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
    }
    
    func configure() {
        models.append(LanguageOption(title: SettingsViewControllerText.rusLanguageCellTittleText, isSelected: false))
        
        models.append(LanguageOption(title: SettingsViewControllerText.engLanguageCellTittleText, isSelected: false))
    }


    
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        cell.accessoryType = models[indexPath.row].isSelected ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        models[indexPath.row].isSelected = !models[indexPath.row].isSelected
        self.tableView.reloadData()
        if tableView.cellForRow(at: indexPath) != nil {
            
            if indexPath.row == 0 {
                UserDefaults.standard.storeLanguage(AppLanguages.rus.rawValue)
                
            } else {
                UserDefaults.standard.storeLanguage(AppLanguages.eng.rawValue)
            }
            models.removeAll()
            configure()
  
        }
     
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
  
}


