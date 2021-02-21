//
//  PersonalDataViewController.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalDataViewController: UIViewController {
    
    @IBOutlet var policyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var models = [PersonalDataSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PersonalDataCell.self, forCellReuseIdentifier: "personalData")
        
        configureCellText()
        confugureLabel()
        
    }
    
    //MARK: - Methods
    
    func configureCellText() {
        models.append(PersonalDataSection(tittle: "", options: [PersonalDataOption(title: "")]))
        
        models.append(PersonalDataSection(tittle: PersonalDataViewControllerText.nameHeaderText, options: [PersonalDataOption(title: PersonalDataViewControllerText.nameTextFieldText)]))
        
        models.append(PersonalDataSection(tittle: PersonalDataViewControllerText.emailHeaderText, options: [PersonalDataOption(title: PersonalDataViewControllerText.emailTextFieldText)]))
        
    }
    
    func confugureLabel() {
        policyLabel.text = PersonalDataViewControllerText.policyLabelText
    }
    

   
}

extension PersonalDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.identifier, for: indexPath) as? PersonalDataCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
            
        return cell
    }
    
    
}
