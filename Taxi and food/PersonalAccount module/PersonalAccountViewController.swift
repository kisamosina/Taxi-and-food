//
//  PersonalAccountViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalAccountViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logOutButton: LogOutButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    
    }
    
    //MARK: - IBActions
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Methods
    
    private func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }
    
}


extension PersonalAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
