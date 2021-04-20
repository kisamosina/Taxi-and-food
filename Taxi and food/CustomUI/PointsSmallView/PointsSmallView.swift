//
//  PointsSmallView.swift
//  Taxi and food
//
//  Created by mac on 18/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PointsSmallViewProtocol: class {
    
    var interactor: PointsSmallViewInteractorProtocol! { get set }
    
    func setupPoints(_ pointsData: PointsResponseData)
    
//    func updateData()
}

class PointsSmallView: UIView {
    
    //MARK: - Properties
    var interactor: PointsSmallViewInteractorProtocol!
    
    //MARK: - IBOutlets
    @IBOutlet var youHaveLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var spendAllButton: MainBottomButton!
    @IBOutlet var otherAmountButton: UIButton!
    
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
        
        self.spendAllButton.setupAs(.spendAllPoints)
        self.otherAmountButton.setTitle(PointsSmallViewTexts.otherAmountButtonTitle, for: .normal)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func initSubviews() {
        
        
        self.loadFromNib(nibName: PointsSmallViewStringData.nibName.rawValue)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        
        
        self.spendAllButton.setupAs(.spendAllPoints)
        self.otherAmountButton.setTitle(PointsSmallViewTexts.otherAmountButtonTitle, for: .normal)
//        self.youHaveLabel.text = "У вас баллов"
        self.setupConstraints()
         
    }
    
    func initPointsSmallViewInteractor() {
        self.interactor = PointsSmallViewInteractor(view: self)
    }
}
    
extension PointsSmallView: PointsSmallViewProtocol {
//    func updateData() {
//        <#code#>
//    }
    
    func setupPoints(_ pointsData: PointsResponseData) {
        DispatchQueue.main.async {
            let pointsString = String(pointsData.credit)
            let text = TransitionBottomViewTexts.youHaveNPointsText.insert(text: pointsString)
            self.youHaveLabel.text = text
            self.youHaveLabel.setBoldAndOrange(pointsString + " " + TransitionBottomViewTexts.youHaveNPointsText.selectedSuffixText())
        }
    }
    
        
    }
    


