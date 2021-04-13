//
//  FullPathView.swift
//  Taxi and food
//
//  Created by mac on 09/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FullPathView: UIView {
    
    
    //MARK: - Properties
    
//    weak var delegate
    
    var type: FullPathViewType! {
        didSet {
            guard let type = type else { return }
            
            switch type {
                
            case .address:
                self.promoAndPointsStackView.isHidden = true
                self.collectionView.isHidden = true
                self.mainButton.setupAs(.next)
                
            case .withTariff:
                
                self.promoAndPointsStackView.isHidden = false
                self.collectionView.isHidden = false
                self.mainButton.setupAs(.newOrder)
                
            }
        }
    }
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var promoAndPointsStackView: UIStackView!
    @IBOutlet var mainButton: MainBottomButton!
    
    @IBOutlet var addressFromTextfield: UITextField!
    @IBOutlet var addressToTextfield: UITextField!
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
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
    
    private func initCollectionView() {
      let nib = UINib(nibName: "FullPath", bundle: nil)
      collectionView.register(nib, forCellWithReuseIdentifier: "FullPath")
        collectionView.dataSource = self
    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: FullPathViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
//        self.mainButton.setupAs(.approve)
//        self.locationTextField.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setView(as type: FullPathViewType ) {
        self.type = type
    }
    
}



extension FullPathView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullPath", for: indexPath) as? FullPathCollectionViewCell else { return UICollectionViewCell() }
        
        //        cell.showData(for: <#T##FullPathCellData#>, advantage: <#TariffAdvantage#>)
        
        return cell
    }
    
    
}
