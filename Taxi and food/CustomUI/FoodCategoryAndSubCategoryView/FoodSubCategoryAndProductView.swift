//
//  FoodCategoryAndSubCategoryView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodSubCategoryAndProductView: CustomBottomView {
    
    //MARK: - Properties
    
    private var subategoryCollectionViewData: [ProductsResponseData] = [] {
        didSet {
            self.subCategoryCollectionView.reloadData()
        }
    }
    
    private var productsCollectionViewData: [ProductsResponseData] = [] {
        didSet {
            self.productsCollectionView.reloadData()
        }
    }

    weak var delegate: FoodSubcategoryAndProductViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var shopTitleLabel: UILabel!
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.delegate?.backButtonTapped()
    }
    
    // MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: FoodCategoryAndSubCategoryViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.containerView.backgroundColor = .clear
        self.setupConstraints()
        let cellSubCategoryNib = UINib(nibName: FoodCategoryAndSubCategoryViewStringData.subCategoryCollectionViewCellReuseId.rawValue, bundle: nil)
        let cellProductNib = UINib(nibName: FoodCategoryAndSubCategoryViewStringData.productsCollectionViewReuseId.rawValue, bundle: nil)
        subCategoryCollectionView.register(cellSubCategoryNib, forCellWithReuseIdentifier: FoodCategoryAndSubCategoryViewStringData.subCategoryCollectionViewCellReuseId.rawValue)
        productsCollectionView.register(cellProductNib, forCellWithReuseIdentifier:  FoodCategoryAndSubCategoryViewStringData.productsCollectionViewReuseId.rawValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func bind(shopTitle: String, categoryTitle: String, subcategoryCollectionViewData: [ProductsResponseData], productsCollectionViewData: [ProductsResponseData]) {
        self.categoryTitleLabel.text = categoryTitle
        self.shopTitleLabel.text = shopTitle
        self.subategoryCollectionViewData = subcategoryCollectionViewData
        self.productsCollectionViewData = productsCollectionViewData
    }

}


extension FoodSubCategoryAndProductView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
                
        case subCategoryCollectionView:
            return self.subategoryCollectionViewData.count
            
        case productsCollectionView:
            return self.productsCollectionViewData.count
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
                
        case subCategoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryAndSubCategoryViewStringData.subCategoryCollectionViewCellReuseId.rawValue, for: indexPath) as! SubCategoryCollectionViewCell
            let cellData = subategoryCollectionViewData[indexPath.row]
            cell.bind(subcategoryData: cellData)
            return cell
        case productsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryAndSubCategoryViewStringData.productsCollectionViewReuseId.rawValue, for: indexPath) as! ProductCollectionViewCell
            let cellData = productsCollectionViewData[indexPath.row]
            cell.bind(cellData: cellData)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        switch collectionView {
        
        case productsCollectionView:
            let width = productsCollectionView.bounds.width
            let insetsSum: CGFloat = 60
            let cellHeight: CGFloat = 210
            let cellWidth = (width - insetsSum) / 2
            return CGSize (width: cellWidth, height: cellHeight)
            
        default:
            return CGSize.zero
        }
        
    }
}
