//
//  MapButtonView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class MapButtonView: UIView {

    //MARK: - Properties
    
    weak var delegate: MapButtonViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
    @IBAction func viewButtonTapped(_ sender: UIButton) {
        self.delegate?.mapButtonTapped()
    }
    
    //MARK: - Methods
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: MapButtonViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.titleLabel.text = MapButtonViewText.title
        
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
