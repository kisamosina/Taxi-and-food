//
//  FoodSubCategoryView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodSubCategoryView: CustomBottomView {
    
    private var subCategoryList: [ProductsResponseData] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    weak var delegate: FoodSubCategoryViewDelegate!
    
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
        self.loadFromNib(nibName: FoodSubCategoriesViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.containerView.backgroundColor = .clear
        super.anchorView.backgroundColor = Colors.whiteTransparent.getColor()
        let nib = UINib(nibName: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func bind(shopTitle: String, categoryTitle: String, and data: [ProductsResponseData]) {
        self.shopTitleLabel.text = shopTitle
        self.categoryTitleLabel.text = categoryTitle
        self.subCategoryList = data
    }
    
}

extension FoodSubCategoryView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.subCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue, for: indexPath) as! FoodSubCategoryCell
        let cellTitle = self.subCategoryList[indexPath.row].name
        cell.bind(subcategoryTitle: cellTitle)
        return cell
    }
}
