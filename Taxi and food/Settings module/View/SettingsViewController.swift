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
    var VC = LanguageViewController()
    
    
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    

    //MARK: - Lifecycle
    
    
    //MARK: - IBActions
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsStaticCell.self, forCellReuseIdentifier: "StaticCell")
        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: "SwitchCell")
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: nil, action: nil)
        
        models.removeAll()
        configure()
        self.tableView.reloadData()
    }
    
    //MARK: - IBActions
    
    //MARK: - Methods
    
    func configure() {
        models.append(Section(tittle: "", options: [
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.languageCellTitleText)),
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.personalDataCellTitleText)),
            
            .switchCell(model: SettingsSwitchOption(title: SettingsViewControllerText.pushCellTitleText, isOn: false))
            
        ]))
        
        models.append(Section(tittle: "", options: [
            .switchCell(model: SettingsSwitchOption(title: SettingsViewControllerText.promoNotificationCellTitleText, isOn: true)),
            .staticCell(model: SettingsOption(title: SettingsViewControllerText.availablePromoCellTitleText))
            
        ]))
        
        models.append(Section(tittle: SettingsViewControllerText.headerTitleText, options: [
            .switchCell(model: SettingsSwitchOption(title: SettingsViewControllerText.refreshCellTitleText, isOn: true))
        ]))
    }
    
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
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
       
        let storyboard1 = UIStoryboard(name: StoryBoards.Settings.rawValue, bundle: nil)
        let storyboard2 = UIStoryboard(name: StoryBoards.PersonalData.rawValue, bundle: nil)
        let storyboard3 = UIStoryboard(name: StoryBoards.Promo.rawValue, bundle: nil)
           
           if indexPath.section == 0 && indexPath.row == 0 {
               
               let vc = storyboard1.instantiateViewController(identifier: ViewControllers.LanguageViewController.rawValue)
               self.navigationController?.pushViewController(vc, animated: true)
               
           }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let vc = storyboard2.instantiateViewController(identifier: ViewControllers.PersonalDataViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            
            let vc = storyboard3.instantiateViewController(identifier: ViewControllers.PromoViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
       }
  
}

    
    




