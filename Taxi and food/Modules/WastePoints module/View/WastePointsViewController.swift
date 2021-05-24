//
//  WastePointsViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 30.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

class WastePointsViewController: SubstrateViewController {
    
    //MARK: - Properties
    
    internal var interactor: WastePointsInteractorProtocol
    
    weak var delegate: WastePointsViewControllerDelegate?
    
    private var wastePointsView: TransitionBottomView!
    
    private var wastePointsViewBottomConstraint: NSLayoutConstraint!
    
    private var pointsEnterView: TextEnterView!
    
    private var pointsEnterViewBottomConstraint: NSLayoutConstraint!
    
    private var kbHeight: CGFloat?
    
    //MARK: - Initializers
    
    required init(interactor: WastePointsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init from coder not implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardWillShowObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showWastePointsView(credit: interactor.credits)
    }
    
    //MARK: - Methods
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        guard let kbHeight = getKeyBoardHeight(notification: notification) else { return }
        self.kbHeight = kbHeight
//        pointsEnterViewBottomConstraint = pointsEnterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding)
//        if pointsEnterViewBottomConstraint.constant == -bottomPadding {
//            pointsEnterViewBottomConstraint.constant = -kbHeight + 20
//        }
    }
    
}

//MARK: - WastePointsViewProtocol

extension WastePointsViewController: WastePointsViewProtocol { }

//MARK: - WastePointsView Methods

extension WastePointsViewController {
    
    private func showWastePointsView(credit: Int) {
        let viewHeight = TransitionBottomViewSizes.whenPointsHeght.rawValue
        let rect = CGRect.makeRect(height: viewHeight)
        wastePointsView = TransitionBottomView(frame: rect)
        view.addSubview(wastePointsView)
        wastePointsView.setupAs(type: .wastePoints(credit))
        wastePointsView.delegate = self
        wastePointsView.setupConstraints(for: view,
                                         viewHeight: viewHeight,
                                         bottomContraintConstant: viewHeight + bottomPadding) { [weak self] bottomconstraint in
            guard let self = self else { return }
            self.wastePointsViewBottomConstraint = bottomconstraint
        }
        
        Animator.shared.showView(animationType: .usualBottomAnimation(wastePointsView, wastePointsViewBottomConstraint), from: view)
    }
    
    private func hideWastePointsView(completion: AnimationCompletion? = nil) {
        let viewHeight = TransitionBottomViewSizes.whenPointsHeght.rawValue
        Animator.shared.hideView(animationType: .usualBottomAnimation(wastePointsView, wastePointsViewBottomConstraint), from: view, viewHeight: viewHeight, completion: completion)
    }
}

//MARK: - TransitionBottomViewDelegate

extension WastePointsViewController: TransitionBottomViewDelegate {
    
    func mainButtonTapped(for viewType: TransitionBottomViewTypes) {
        guard interactor.checkEnteredPointsWithOrderSum(points: interactor.credits) else {
            dismiss(animated: true)
            return
        }
        delegate?.waste(points: interactor.credits)
        dismiss(animated: true)
    }
    
    func auxButtonTapped(for viewType: TransitionBottomViewTypes) {
        hideWastePointsView { [weak self] _ in
            guard let self =  self else { return }
            self.showPointsEnterView()
        }
    }
    
    func userHasSwipedDown(for viewType: TransitionBottomViewTypes) {
        hideWastePointsView {[dismiss] _ in
            dismiss(false, nil)
        }
    }
}

//MARK: - PointsEnterView Methods

extension WastePointsViewController {
    
    private func showPointsEnterView() {
        let rect = CGRect.makeRect(height: TextEnterViewSize.height.rawValue)
        pointsEnterView = TextEnterView(frame: rect)
        pointsEnterView.textField.keyboardType = .numberPad
        pointsEnterView.delegate = self
        pointsEnterView.upView.alpha = 0
        view.addSubview(pointsEnterView)
        pointsEnterView.translatesAutoresizingMaskIntoConstraints = false
        
        if let kbHeight = self.kbHeight {
            pointsEnterViewBottomConstraint = pointsEnterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kbHeight + 20)
            pointsEnterViewBottomConstraint.isActive = true
        } else {
            pointsEnterViewBottomConstraint = pointsEnterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding)
            pointsEnterViewBottomConstraint.isActive = true
        }
        
        pointsEnterView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        pointsEnterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pointsEnterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//MARK: - PointsEnterViewDelegate

extension WastePointsViewController: TextEnterViewDelegate {
    
    func approveButtonTapped(_ text: String) {
        guard let points = Int(text) else { return }
        
        guard interactor.checkEnteredPointsWithCredits(points: points) else {
            pointsEnterView.setupError(description: WastePointsModuleTexts.errorWhenEnteredPointsMoreCreditsDescription)
            return
        }
        
        guard interactor.checkEnteredPointsWithOrderSum(points: points) else {
            pointsEnterView.setupError(description: WastePointsModuleTexts.errorWhenEnteredPointsMoreOrderSumDescription)
            return
        }
        
        delegate?.waste(points: points)
        dismiss(animated: true)
        
    }
    
    
}
