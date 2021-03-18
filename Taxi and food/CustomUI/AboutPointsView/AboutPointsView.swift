//
//  AboutPointsView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AboutPointsView: UIView {
    
    weak var delegate: AboutPointsViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var closeButton: CloseMenuButton!
    
    @IBOutlet weak var beginSavePointsButton: MainBottomButton!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    //MARK: - IBActions
    
    @IBAction func beginSavePointsButtonTapped(_ sender: UIButton) {
        self.delegate?.beginSavePointsButtonTapped()
    }
    
    
    @IBAction func closeButtonTapped(_ sender: CloseMenuButton) {
        self.delegate?.closeButtonTapped()
    }
    
    @IBAction func userSwipedDown(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.delegate?.userHasSwipedViewDown()
        }
    }
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Layout setup
        self.clipsToBounds = true
        self.layer.cornerRadius = TransitionBottomViewSizes.cornerRadius.rawValue

    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: AboutPointsViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.beginSavePointsButton.setupAs(.beginSavePoints)
        self.titleLabel.text = AboutPointsViewTexts.titleText
        self.descriptionLabel.text = AboutPointsViewTexts.descriptionText
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
