//
//  FoodCategoriesView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class FoodCategoriesView: CustomBottomView {
    
    //MARK: - Properties
    
    private var shopDetailData: ShopDetailResponseData? {
        didSet {
            self.shopTitleLabel.text = ShopDetailTexts.shopTitle + " \(shopDetailData?.name ?? "")"
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
        
    @IBOutlet weak var shopTitleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoButton.backgroundColor = .clear
        infoButton.layer.cornerRadius = self.infoButton.frame.height/2
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = Colors.buttonBlue.getColor().cgColor
        infoButton.setTitleColor(Colors.buttonBlue.getColor(), for: .normal)
    }

    // MARK: - IBActions

    @IBAction func infoButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
    }
    
    
    // MARK: - Methods
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: ShopDetailStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.containerView.backgroundColor = .clear
        self.setupConstraints()
        let nib = UINib(nibName: ShopDetailStringData.collectioViewCellReuseId.rawValue, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ShopDetailStringData.collectioViewCellReuseId.rawValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setFoodData(_ data: ShopDetailResponseData) {
        self.shopDetailData = data
    }

}


extension FoodCategoriesView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopDetailData?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopDetailStringData.collectioViewCellReuseId.rawValue,
                                                           for: indexPath) as! FoodCategoryCollectionViewCell
        guard let category = self.shopDetailData?.categories[indexPath.row] else { return UICollectionViewCell() }
        cell.bindCell(by: category)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let cellnumbersOnScreen: CGFloat = 2
        let workSpace = (screenWidth - ShopDetailSizeData.collectionViewSummInsets.rawValue)/cellnumbersOnScreen
        
        return CGSize(width: workSpace, height: ShopDetailSizeData.collectionViewCellHeight.rawValue)
    }
    
}
