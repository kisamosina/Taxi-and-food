//
//  PromocodeActivatingViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 29.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeActivatingViewController: SubstrateViewController {
    
    // MARK: - Properties
    
    let interactor: PromocodeActivatingInteractorProtocol
    weak var delegate: PromocodeActivatingViewControllerDelegate?
    
    private var promocodeEnterView: TextEnterView! = {
        let rect = CGRect.makeRect(height: TextEnterViewSize.height.rawValue)
        let view = TextEnterView(frame: rect)
        view.upView.alpha = 0
        return view
    }()
    
    private var promocodeEnterViewBottomConstraint: NSLayoutConstraint!
    
    private var  promocodeActivatingResultView: PromocodeActivatingResultView!
    
    private var promocodeActivatingResultViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Initializers
    
    required init(interactor: PromocodeActivatingInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init from coder not implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        addKeyboardWillShowObserver()
        promocodeEnterView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(promocodeEnterView)
        self.promocodeEnterView.setupConstraints(for: self.view, viewHeight: 180, bottomContraintConstant: -bottomPadding) { [weak self] bottomconstraint in
            guard let self =  self else { return }
            self.promocodeEnterViewBottomConstraint = bottomconstraint
        }
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        guard let kbHeight = getKeyBoardHeight(notification: notification) else { return }
        if promocodeEnterViewBottomConstraint.constant == -bottomPadding {
            promocodeEnterViewBottomConstraint.constant = -kbHeight + 20
        }
    }

    
}

extension PromocodeActivatingViewController: PromocodeActivatingViewProtocol {
    
    func promocodeActivated(description: String) {
        let discount = Int.random(in: 3...15)
        DispatchQueue.main.async {
            self.promocodeEnterView.removeFromSuperview()
            self.promocodeEnterView = nil
            self.promocodeEnterViewBottomConstraint = nil
            self.showPromocodeActivatingResultView(description: description)
            self.delegate?.promocodeHasActivated(discount: discount)
        }
    }
    
    func promocodeAlreadyActivated() {
        DispatchQueue.main.async {
            self.promocodeEnterView.setupError(description: PromocodeEnterViewControllerTexts.promocodeAlreadyHas)
        }
    }
    
    func invalidPromocode() {
        DispatchQueue.main.async {
            self.promocodeEnterView.setupError(description: PromocodeEnterViewControllerTexts.invalidPromocode)
        }
    }
}

//MARK: - PromocodeActivatingResultView methods

extension PromocodeActivatingViewController {
    
    private func showPromocodeActivatingResultView(description: String) {
        let viewHeight = PromocodeActivatingResultSizesData.viewHeight.rawValue
        let rect =  CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: viewHeight)
        promocodeActivatingResultView = PromocodeActivatingResultView(frame: rect)
        view.addSubview(promocodeActivatingResultView)
        promocodeActivatingResultView.setupConstraints(for: view,
                                                       viewHeight: viewHeight, bottomContraintConstant: viewHeight + bottomPadding) { [weak self] bottomconstraint in
            guard let self = self else { return }
            self.promocodeActivatingResultViewBottomConstraint = bottomconstraint
        }
        
        promocodeActivatingResultView.setupActivated(description: description)
        
        Animator.shared.showView(animationType: .usualBottomAnimation(promocodeActivatingResultView, promocodeActivatingResultViewBottomConstraint), from: view)
    }
}

// MARK: - TextEnterViewDelegate

extension PromocodeActivatingViewController: TextEnterViewDelegate {
    
    func approveButtonTapped(_ text: String) {
        interactor.promocodeActivate(promocode: text)
    }
}
