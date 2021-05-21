//
//  TaxiHasFoundViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TaxiFoundViewController: SubstrateViewController {
    
    //MARK: - Properties
    
    var interactor: TaxiFoundInteractorProtocol
    weak var delegate: TaxiFoundViewControllerDelegate?
    
    private var taxiHasFoundView: TaxiHasFoundView!
    private var taxiHasFoundViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Initializers
    
    required init(interactor: TaxiFoundInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.InactiveViewColor.getColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTaxiHasFoundView()
    }
    
    //MARK: - Methods
    
}

//MARK: - TaxiHasFoundViewProtocol

extension TaxiFoundViewController: TaxiFoundViewProtocol {
    
}

// MARK: - Show TaxiHasFoundView

extension TaxiFoundViewController {
    
    func showTaxiHasFoundView() {
        taxiHasFoundView = TaxiHasFoundView(frame: CGRect.makeRect(height: TaxiHasFoundViewSizes.viewHeight))
        view.addSubview(taxiHasFoundView)
        taxiHasFoundView.setupConstraints(for: view,
                                          viewHeight: TaxiHasFoundViewSizes.viewHeight,
                                          bottomContraintConstant: TaxiHasFoundViewSizes.viewHeight + bottomPadding) { [weak self] constraint in
            guard let self = self else { return }
            self.taxiHasFoundViewBottomConstraint = constraint
        }
        
        Animator.shared.showView(animationType: .usualBottomAnimation(taxiHasFoundView, taxiHasFoundViewBottomConstraint), from: view)
    }
}
