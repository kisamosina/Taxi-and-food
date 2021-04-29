//
//  ShopDetailView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ShopDetailView: CustomBottomView {
    
    weak var delegate: ShopDetailViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var shopTitleLabel: UILabel!
    
    @IBOutlet weak var shopAddressLabel: UILabel!
    
    @IBOutlet weak var shopWorkTimeLabel: UILabel!
    
    @IBOutlet weak var productsShopLabel: UILabel!
    
    @IBOutlet weak var shopDescriptionLabel: UILabel!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }    
    
    //MARK: - IBActions
    
    @IBAction func closeButtonTapped(_ sender: CloseMenuButton) {
        self.delegate?.closeButtonTapped()
    }
    
    // MARK: - Methods

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func bindView(for data: FoodCategoriesResponseData) {
        self.shopTitleLabel.text = data.name
        self.shopAddressLabel.text = data.address
        self.shopWorkTimeLabel.text = data.schedule
        self.productsShopLabel.text = data.categories.map { $0.name }.joined(separator: " • ")
        self.shopDescriptionLabel.text = data.description
        
    }
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: ShopDetailViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.containerView.backgroundColor = .clear
        super.anchorView.backgroundColor = .clear
    }
}
