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
    @IBOutlet weak var resultIconImageView: UIImageView!
    @IBOutlet var messageSentLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var successButton: MainBottomButton!
    @IBOutlet weak var problemButton: AuxiliaryButton!
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.showData()
    }
    

    
    //MARK: - IBAction
    @IBAction func successButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func setupUI() {
        self.successButton.setupAs(.perfect)
        problemButton.setupAs(type: .tellAboutProblem)
    }
    
   private func showData() {
        switch self.showingCase {
        case .promocode(let promocode):
            messageSentLabel.textColor = Colors.textColorGreen.getColor()
            self.messageSentLabel.text = PromocodeEnterViewControllerTexts.promocodeActivated
            self.infoLabel.text = promocode.description
            problemButton.isHidden = true
        case .continueTaxiSearch:
            messageSentLabel.textColor = Colors.textColorGreen.getColor()
            messageSentLabel.text = SentViewControllerTexts.searchTaxiContinueHeader
            infoLabel.text = SentViewControllerTexts.searchTaxiTextBody
            problemButton.isHidden = true
            navigationItem.title = SentViewControllerTexts.searchTaxiContinueNavTitle
        case .cancelationTaxiOrder:
            resultIconImageView.image = UIImage(named: CustomImagesNames.iconCancelFace.rawValue)
            messageSentLabel.textColor = Colors.taxiOrange.getColor()
            messageSentLabel.text = SentViewControllerTexts.cancelationTaxiOrderHeader
            infoLabel.text = SentViewControllerTexts.cancelationTaxiOrderTextBody
            successButton.setupAs(.anotherOrder)
            navigationItem.title = SentViewControllerTexts.cancelationTaxiOrderNavTitle
        case .none:
            problemButton.isHidden = true
        }
    }
    
    
    public func configAs(_ showingCase: SentViewControllerShowingCases) {
        self.showingCase = showingCase
    }

}
