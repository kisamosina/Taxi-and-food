//
//  ShopsView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 31.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ShopsView: UIView {
    
    private var shopList: [ShopResponseData] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    weak var delegate: ShopsViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }

    // MARK: - IBActions
    
    
    @IBAction func userHasSwipedViewDown(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.delegate?.userHasSwipedDownView()
        }
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Layout setup
        self.contentView.layer.cornerRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.contentView.layer.shadowOpacity = Float(TransitionBottomViewSizes.shadowOpacity.rawValue)
        self.contentView.layer.shadowRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowOffset = CGSize(width: TransitionBottomViewSizes.shadowOffsetWidth.rawValue,
                                                     height: TransitionBottomViewSizes.shadowOffsetWidth.rawValue)
        self.contentView.layer.masksToBounds = false
        self.topView.layer.cornerRadius = self.topView.frame.height/2
        self.topView.clipsToBounds = true
        
    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: ShopsViewNibsNames.ShopsView.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        let nib = UINib(nibName: ShopsViewNibsNames.ShopsCollectionViewCell.rawValue, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ShopsViewStringData.cellReuseId.rawValue)
    }

    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setShopView(list: [ShopResponseData], destinationAddress: String?, destinationTitle: String?) {
        self.shopList = list
        self.placeLabel.text = destinationTitle ?? ""
        self.placeAddressLabel.text = destinationAddress ?? ""
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewFlowLayout

extension ShopsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopsViewStringData.cellReuseId.rawValue, for: indexPath) as! ShopsCollectionViewCell
        let shopModel = self.shopList[indexPath.row]
        cell.bind(shopModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let cellnumbersOnScreen: CGFloat = 2
        let workSpace = (screenWidth - ShopsViewUIData.summCollectionViewInsets.rawValue)/cellnumbersOnScreen
        
        return CGSize(width: workSpace, height: ShopsViewUIData.cellHeight.rawValue)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopId = self.shopList[indexPath.row].id
        self.delegate?.goToShop(shopId)
    }
}
