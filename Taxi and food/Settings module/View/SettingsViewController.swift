//
//  SettingsViewController.swift
//  Taxi and food
//
//  Created by mac on 18/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - Properties
    
    var models = [Section]()
    
    
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    

    //MARK: - Lifecycle
    
    
    //MARK: - IBActions
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingsStaticCell.self, forCellReuseIdentifier: "StaticCell")
        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: "SwitchCell")
        
        configure()

       
    }
    
    //MARK: - IBActions
    
    //MARK: - Methods
    
    func configure() {
        models.append(Section(tittle: "", options: [
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.languageCellTitleText, handler: {})),
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.personalDataCellTitleText, handler: {})),
            
            .switchCell(model: SettingsSwitchOption(title: SettingsViewControllerText.pushCellTitleText, handler: {}, isOn: true))
            
        ]))
        
        models.append(Section(tittle: "", options: [
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.promoNotificationCellTitleText, handler: {})),
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.availablePromoCellTitleText, handler: {}))
            
        ]))
        
        models.append(Section(tittle: SettingsViewControllerText.headerTitleText, options: [
            .switchCell(model: SettingsSwitchOption(title: SettingsViewControllerText.refreshCellTitleText, handler: {}, isOn: true))
        ]))
    }
}
    

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.tittle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsStaticCell.identifier, for: indexPath) as? SettingsStaticCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchCell.identifier, for: indexPath) as? SettingsSwitchCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "language", sender: self)
        }
        
        switch type.self {
        case .staticCell(model: let model):
            model.handler()
        case .switchCell(model: let model):
            model.handler()
        }
 
    }
    
    
}
