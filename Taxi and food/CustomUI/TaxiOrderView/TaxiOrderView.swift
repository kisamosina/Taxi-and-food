//
//  TaxiOrderView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TaxiOrderView: CustomBottomView {
    
    //MARK: - Properties
    
    public weak var delegate: TaxiOrderViewDelegate?
    private var tariffs: [Tariff] = Tariff.getTariffs()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var addressFromTextField: UITextField!
    
    @IBOutlet weak var addressFromUnderLineView: UIView!
    
    @IBOutlet weak var addressToTextField: UITextField!
    
    @IBOutlet weak var addressToUnderLineView: UIView!
    
    @IBOutlet weak var tariffsCollectionView: UICollectionView!
    
    @IBOutlet weak var discountStackView: UIStackView!
    
    @IBOutlet weak var orderButton: MainBottomButton!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    //MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: TaxiOrderViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.containerView.backgroundColor = .clear
        let nib = UINib(nibName: TaxiOrderViewStringData.tariffsCollectionViewCellReuseId.rawValue, bundle: nil)
        self.tariffsCollectionView.register(nib, forCellWithReuseIdentifier: TaxiOrderViewStringData.tariffsCollectionViewCellReuseId.rawValue)
        self.orderButton.setupAs(.next)
        self.orderButton.setActive()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setupAdresses(from source: String, to destination: String) {
        self.addressFromTextField.text = source
        self.addressToTextField.text = destination
    }

    override func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        super.userHasSwipedDown(sender)
        self.delegate?.viewHasSwipedDown()
    }
}

extension TaxiOrderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariffs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaxiOrderViewStringData.tariffsCollectionViewCellReuseId.rawValue, for: indexPath) as! TaxiOrderCollectionViewCell
        let tariff = tariffs[indexPath.row]
        cell.bindCell(for: tariff)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - TaxiOrderViewSizesData.collectionViewSumOffsets.rawValue) / 3
        return CGSize(width: cellWidth, height: TaxiOrderViewSizesData.tariffCellHeight.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for tariff in tariffs { tariff.setActive(false) }
        self.tariffs[indexPath.row].setActive(true)
        self.tariffsCollectionView.reloadData()
    }
}
