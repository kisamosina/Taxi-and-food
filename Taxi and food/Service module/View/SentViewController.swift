//
//  SentViewController.swift
//  Taxi and food
//
//  Created by mac on 15/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class SentViewController: UIViewController {
    
    var showingCase: SentViewControllerShowingCases!
    
    
    //MARK: - IBOutlets
    @IBOutlet var messageSentLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var successButton: MainBottomButton!
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.successButton.setupAs(.perfect)
        self.showData()
    }
    

    
    //MARK: - IBAction
    @IBAction func successButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func showData() {
        switch self.showingCase {
        case .promocode(let promocode):
            self.messageSentLabel.text = PromocodeEnterViewControllerTexts.promocodeActivated
            self.infoLabel.text = promocode.description
        case .none:
            break
        }
    }
    
    
   

}
