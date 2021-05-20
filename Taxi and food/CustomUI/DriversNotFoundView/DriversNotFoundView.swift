//
//  DriversNotFoundView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DriversNotFoundView: CustomBottomView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weWillSentPushLabel: UILabel!
    @IBOutlet weak var continueSearchingButton: MainBottomButton!
    @IBOutlet weak var cancelButton: AuxiliaryButton!
    
    //MARK: - Initializer
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.initSubViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.initSubViews()
//    }
    
    //MARK: - IBActions
    
    @IBAction func continueSearchingButtonTapped(_ sender: MainBottomButton) {
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: AuxiliaryButton) {
    }
    
    //MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: String(describing: DriversNotFoundView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        containerView.backgroundColor = .clear
        infoLabel.setText(text: DriverNotFoundViewTexts.driverIsNotNearby, of: .boldOrange())
        descriptionLabel.setText(text: DriverNotFoundViewTexts.isNotNearbyDescription, of: .lightGrey())
        weWillSentPushLabel.setText(text: DriverNotFoundViewTexts.weWillSendYouPush, of: .normalGrey(DriversNotFoundViewSizes.weWillSentPushLabelFontSize))
        continueSearchingButton.setupAs(.continueSearching)
        cancelButton.setupAs(type: .cancel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

}
