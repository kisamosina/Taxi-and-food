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
    
    var models = [SettingsOption]()
    
    
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    

    //MARK: - Lifecycle
    
    
    //MARK: - IBActions
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()

       
    }
    
    //MARK: - IBActions
    
    //MARK: - Methods
    
    func configure() {
        self.models = Array(0...100).compactMap({
            SettingsOption(title: "Item \($0)", handler: {})
            
        })
    }
    

    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.titleLabel?.text = model.title
        return cell
    }
    
    
}
