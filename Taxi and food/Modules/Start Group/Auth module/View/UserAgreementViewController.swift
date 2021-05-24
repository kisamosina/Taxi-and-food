//
//  UserAgreementViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit

class UserAgreementViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabelText()
    }

    private func setupTitleLabelText() {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            self.titleLabel.text = "Пользовательское соглашение"
        case .eng:
            self.titleLabel.text = "User agreement"
        }
    }
    
}
