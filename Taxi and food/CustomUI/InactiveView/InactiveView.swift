//
//  InactiveView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class InactiveView: UIView {
    
    weak var delegate: InactiveViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTapGestureRecognizer()
        self.backgroundColor = Colors.InactiveViewColor.getColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTapGestureRecognizer()
        self.backgroundColor = Colors.InactiveViewColor.getColor()
    }
    
    private func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.userHasTapped()
     }
}
