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
        switch AppSettings.shared.language {
            
        case .rus:
            titleLabel.text = "Пользовательское соглашение"
        case .en:
            titleLabel.text = "User agreement"
        }
    }
    
}
