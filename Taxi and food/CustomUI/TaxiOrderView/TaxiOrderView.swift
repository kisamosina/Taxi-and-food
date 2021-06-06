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
    public weak var mapButtonDelegate: MapButtonDelegate?
    private var taxipricesData: [TaxiPriceResponseModel] = []
    private var tariffs: [Tariff] = []
    private var selectedIndex = 0
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var addressFromTextField: UITextField!
    
    @IBOutlet weak var addressFromUnderLineView: UIView!
    
    @IBOutlet weak var addressToTextField: UITextField!
    
    @IBOutlet weak var mapButtonView: MapButtonView!
    
    @IBOutlet weak var addressToUnderLineView: UIView!
    
    @IBOutlet weak var tariffsCollectionView: UICollectionView!
    
    @IBOutlet weak var discountStackView: UIStackView!
    
    @IBOutlet weak var promocodeButtonView: DiscountsButtonView!
    
    @IBOutlet weak var pointsButtonView: DiscountsButtonView!
    
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
        self.orderButton.setupAs(.order)
        self.orderButton.setActive()
        mapButtonView.delegate = self
        setupTapActions()

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupTapActions() {
        let promocodeButtonViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(promocodeEnterViewHasTaped))
        self.promocodeButtonView.addGestureRecognizer(promocodeButtonViewTapRecognizer)
        let pointsButtonViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pointsEnterViewHasTapped))
        self.pointsButtonView.addGestureRecognizer(pointsButtonViewTapRecognizer)
    }
    
    @objc func promocodeEnterViewHasTaped(_ sender: UITapGestureRecognizer) {
        delegate?.promocodeButtonTapped()
    }
    
    @objc func pointsEnterViewHasTapped(_ sender: UITapGestureRecognizer) {
        delegate?.pointsButtonTapped()
    }
    
    @IBAction func orderButtonTapped(_ sender: MainBottomButton) {
        delegate?.orderButtonTapped()
    }
    
    public func setupAdresses(from source: String, to destination: String) {
        self.addressFromTextField.text = source
        self.addressToTextField.text = destination
    }
    
    public func setDestinationAddress(destinationAddress: String) {
        self.addressToTextField.text = destinationAddress
    }
    
    override func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        super.userHasSwipedDown(sender)
        self.delegate?.viewHasSwipedDown()
    }
    
    public func bind(taxiPrices: [TaxiPriceResponseModel]) {
        self.taxipricesData = taxiPrices
        tariffs = Tariff.getTariffs(from: taxiPrices)
    }
    
    public func setNewPrice(_ newPrice: Double) {
        tariffs = Tariff.getTariffs(from: taxipricesData)
        for tariff in tariffs { tariff.setActive(false) }
        self.tariffs[selectedIndex].setActive(true)
        self.tariffs[selectedIndex].setNewPrice(newPrice: newPrice)
        self.tariffsCollectionView.reloadData()
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
        selectedIndex = indexPath.row
        delegate?.tariffSelected(tariffId: tariffs[indexPath.row].id, tariffPrice: tariffs[indexPath.row].getTariffPrice())
        for tariff in tariffs { tariff.setActive(false) }
        self.tariffs[indexPath.row].setActive(true)
        self.tariffsCollectionView.reloadData()
    }
}

//MARK: - MapButtonViewDelegate
extension TaxiOrderView: MapButtonViewDelegate {
    
    func mapButtonTapped() {
        self.mapButtonDelegate?.mapButtonTapped(destinationAddress: addressToTextField.text)
    }
}
