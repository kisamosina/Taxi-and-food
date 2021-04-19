//
//  PromocodeEnterView.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeEnterView: UIView {
    
    weak var delegate: PromocodeEnterViewDelegate!
    
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
    
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    //MARK: - Properties
    var interactor: PromocodeEnterInteractorProtocol!
    
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
        self.setupConstraints()
        
        self.interactor = PromocodeEnterInteractor(view: self)

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
    
    public func setView(as type: PromocodeEnterViewType) {
        self.type = type
    }
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        self.delegate?.approveButtonDidTapped()
    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        self.mainButton.setActive()
    }
    
}

extension PromocodeEnterView:PromocodeEnterViewProtocol {
    func setupLabelError(text: String) {
        
    }
    
    func showSuccess(data: PromocodeDataResponse) {
        
    }
    
    
}

//extension PromocodeEnterView: PromocodeEnterCustomInteractorProtocol {
//    func requestPromocodeActivate(code: String) {
//        guard let id = PersistanceStoreManager.shared.getUserData()?[0].id
//            else {
//                print("No user id in storage")
//                return
//
//            }
//
//            let promocodeResource = Resource<PromocodeResponse>(path: PromocodesRequestPaths.activate.rawValue.getServerPath(for: Int(id)),
//                                                              requestType: .POST,
//                                                              requestData: [PromocodesRequestKeys.code.rawValue: code])
//
//            NetworkService.shared.makeRequest(for: promocodeResource, completion:  { result in
//
//                switch result {
//
//                case .success(let promocodeResponse):
////                    self.view.showSuccess(data: promocodeResponse.data)
//                case .failure(let error):
//                    if let serverError = error as? ServerErrors {
//                        switch serverError.statusCode {
//                         case 403:
////                            self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.promocodeAlreadyHas)
//
//                        default:
////                            self.view.setupLabelError(text: PromocodeEnterViewControllerTexts.invalidPromocode)
//                        }
//                    }
//                }
//            })
//
//        }
//    }
//
