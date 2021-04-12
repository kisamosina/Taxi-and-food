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
    
    private var foodCategoryData: FoodCategoriesResponseData? {
        didSet {
            self.shopTitleLabel.text = FoodCategoriesViewTexts.shopTitle + " \(foodCategoryData?.name ?? "")"
            self.collectionView.reloadData()
        }
    }
    
    weak var delegate: FoodViewCategoryViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
        
    @IBOutlet weak var shopTitleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
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
        self.delegate?.infoButtonTapped()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.delegate?.backButtonTapped()
    }
    
    
    // MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: FoodCategoriesViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.containerView.backgroundColor = .clear
        super.anchorView.backgroundColor = Colors.whiteTransparent.getColor()
        self.setupConstraints()
        let nib = UINib(nibName: FoodCategoriesViewStringData.collectioViewCellReuseId.rawValue, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: FoodCategoriesViewStringData.collectioViewCellReuseId.rawValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setFoodData(_ data: FoodCategoriesResponseData) {
        self.foodCategoryData = data
    }
    
    override func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        super.userHasSwipedDown(sender)
        if sender.state == .ended {
            self.delegate?.userHasSwipedDown()
        }
    }

}


extension FoodCategoriesView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.foodCategoryData?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoriesViewStringData.collectioViewCellReuseId.rawValue,
                                                           for: indexPath) as! FoodCategoryCollectionViewCell
        guard let category = self.foodCategoryData?.categories[indexPath.row] else { return UICollectionViewCell() }
        cell.bindCell(by: category)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let cellnumbersOnScreen: CGFloat = 2
        let workSpace = (screenWidth - FoodCategoriesViewSizeData.collectionViewSummInsets.rawValue)/cellnumbersOnScreen
        
        return CGSize(width: workSpace, height: FoodCategoriesViewSizeData.collectionViewCellHeight.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let shopId = foodCategoryData?.id, let categoryId = foodCategoryData?.categories[indexPath.row].id else { return }
        self.delegate?.shopSelected(shopId: shopId, with: categoryId)
    }
}
