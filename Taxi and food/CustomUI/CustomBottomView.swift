//
//  CustomBottomView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class CustomBottomView: UIView {
    
    var anchorView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: TextEnterViewUpperViewData.width.rawValue, height: TextEnterViewUpperViewData.height.rawValue)
        let view = UIView(frame: rect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.InactiveViewColor.getColor()
        return view
    }()
    
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.contentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.contentView.layer.shadowOpacity = Float(MapBottomViewUIData.shadowOpacity.rawValue)
        self.contentView.layer.shadowRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.contentView.layer.shadowOffset = CGSize(width: MapBottomViewUIData.shadowOffsetWidth.rawValue,
                                                     height: MapBottomViewUIData.shadowOffsetWidth.rawValue)
        self.contentView.layer.masksToBounds = false
        self.anchorView.layer.cornerRadius = TextEnterViewConstraints.upViewHeight.rawValue / 2
        self.anchorView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupSkeletonConstraints()
        self.setupSwipeDownGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.setupSkeletonConstraints()
        self.setupSwipeDownGestureRecognizer()
    }
    
    private func setupSkeletonConstraints() {
        self.addSubview(anchorView)
        self.addSubview(contentView)
        
        
        NSLayoutConstraint.activate([
            anchorView.topAnchor.constraint(equalTo: self.topAnchor),
            anchorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            anchorView.widthAnchor.constraint(equalToConstant: TextEnterViewUpperViewData.width.rawValue),
            anchorView.heightAnchor.constraint(equalToConstant: TextEnterViewUpperViewData.height.rawValue),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAnchorViewColor(color: UIColor) {
        self.anchorView.backgroundColor = color
    }
}

extension CustomBottomView {
    
    private func setupSwipeDownGestureRecognizer() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(userHasSwipedDown(_:)))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.down
        self.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down, sender.state == .ended {
            print("User has swiped down")
        }
    }
}
