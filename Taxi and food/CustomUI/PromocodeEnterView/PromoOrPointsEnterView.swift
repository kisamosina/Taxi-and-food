//
//  PromocodeEnterView.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoOrPointsEnterViewProtocol: class {
    
    var interactor: PromoOrPointsEnterViewInteractorProtocol! { get set }
    
    func showPromoSuccess(data: PromocodeDataResponse)
    func setupLabelError(text: String)
    
}

//protocol PromoOrPointsViewDelegate: class {
//    func approveButtonTapped(with text: String)
//}

class PromoOrPointsEnterView: UIView {
    
    var interactor: PromoOrPointsEnterViewInteractorProtocol!
    weak var delegate: PromoOrPointsEnterViewDelegate!
    
    var type: PromocodeEnterViewType! {
        didSet {
            guard let type = type else { return }
            
            switch type {
            
            case .promo:
                self.promoTextField.placeholder = PromocodeEnterViewTexts.promoPlaceholderText
            case .points:
                self.promoTextField.placeholder = PromocodeEnterViewTexts.pointsPlaceholderText
            }
        }
    }
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var promoTextField: UITextField!
    @IBOutlet var mainButton: MainBottomButton!
    @IBOutlet var errorLabel: UILabel!
    
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
        
    }
    
    private func initSubviews() {
        self.loadFromNib(nibName: PromocodeEnterViewStringData.nibName.rawValue)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.promoTextField.addBottomBorder(color: Colors.buttonBlue.getColor())
//        self.promoTextField.becomeFirstResponder()
        self.mainButton.setupAs(.approve)
        self.errorLabel.textColor = Colors.redTextColor.getColor()
        self.errorLabel.font = .systemFont(ofSize: TextEnterViewFontSizes.labelFontSize.rawValue)
        self.errorLabel.isHidden = true
        self.setupConstraints()
        
        self.interactor = PromoOrPointsEnterViewInteractor(view: self)
        
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
    
    func initPromoOrPointsEnterViewInteractor() {
        self.interactor = PromoOrPointsEnterViewInteractor(view: self)
    }
    
    public func setView(as type: PromocodeEnterViewType) {
        self.type = type
    }
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        
        guard let text = promoTextField.text, text != "" else { return }

        switch self.type {
        case .promo:
            self.delegate.approveButtonDidTapped(for: .promo, with: text)
        case .points:
            self.delegate.approveButtonDidTapped(for: .points, with: text)
        case .none:
            break
        }
        
    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        self.errorLabel.isHidden = true
        self.mainButton.setActive()
    }
    
}

extension PromoOrPointsEnterView: PromoOrPointsEnterViewProtocol {

    
    func showPromoSuccess(data: PromocodeDataResponse) {
        self.delegate.setUpDescription(data: data)
    }
    
    func setupLabelError(text: String) {
                DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.promoTextField.text = ""
            self.promoTextField.placeholder = ""
            self.errorLabel.text = text
            print("label is set upped")
        }
    }
    
    
    

    }
    

    
    

    
   


