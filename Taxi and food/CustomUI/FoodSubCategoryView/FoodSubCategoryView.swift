//
//  FoodSubCategoryView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodSubCategoryView: CustomBottomView {

    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var shopTitleLabel: UILabel!
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    // MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.setupConstraints()
        super.anchorView.backgroundColor = Colors.whiteTransparent.getColor()
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
