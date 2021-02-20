//
//  LanguageViewController.swift
//  Taxi and food
//
//  Created by mac on 19/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol LanguageViewControllerDelegate: class {
    func update()
}

class LanguageViewController: UIViewController {
    
    var models = [LanguageOption]()
    weak var delegate: LanguageViewControllerDelegate?
    

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        configure()

        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.delegate?.update()
    }
    
    func configure() {
        models.append(LanguageOption(title: SettingsViewControllerText.rusLanguageCellTittleText))
        
        models.append(LanguageOption(title: SettingsViewControllerText.engLanguageCellTittleText))
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            if indexPath.row == 0 {
                UserDefaults.standard.storeLanguage("rus")
            } else {
                UserDefaults.standard.storeLanguage("eng")
            }
           
        }
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
  
}

