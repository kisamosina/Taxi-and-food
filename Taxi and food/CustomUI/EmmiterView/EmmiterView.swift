//
//  EmmiterView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class EmmiterView: UIView {
    
    private let inactiveAlpha: CGFloat = EmmiterViewNumberParametrs.inactiveAlpha
    private let activeAlpha: CGFloat = EmmiterViewNumberParametrs.activeAlpha
    private let animationDuration = EmmiterViewNumberParametrs.animationDuration
    private var isAnimating = false
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var firstSectionImageView: UIImageView!
    @IBOutlet weak var secondSectionImageView: UIImageView!
    @IBOutlet weak var thirdSectionImageView: UIImageView!
    
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    //MARK: - Methods
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: String(describing: EmmiterView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        initSectionsAlpha()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func animateFirstSection(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: animationDuration,
                       animations: { [weak self] in
                        guard let self = self  else { return }
                        self.firstSectionImageView.alpha = self.activeAlpha
        }, completion: completion)
    }
    
    private func animateSecondSection(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: animationDuration,
                       animations: { [weak self] in
                        guard let self = self  else { return }
                        self.secondSectionImageView.alpha = self.activeAlpha
        }, completion: completion)
    }

    private func animateThirdSection(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: animationDuration,
                       animations: { [weak self] in
                        guard let self = self  else { return }
                        self.thirdSectionImageView.alpha = self.activeAlpha
        }, completion: completion)
    }
    
    private func initSectionsAlpha() {
        thirdSectionImageView.alpha = inactiveAlpha
        secondSectionImageView.alpha = inactiveAlpha
        firstSectionImageView.alpha = inactiveAlpha
    }
    
    public func startAnimating() {
        isAnimating = true
        
        animateThirdSection {[weak self] _ in
            guard let self = self, self.isAnimating else { return }
            self.animateSecondSection {[weak self] _ in
                guard let self = self, self.isAnimating else { return }
                self.animateFirstSection {[weak self] _ in
                    guard let self = self, self.isAnimating else { return }
                    self.initSectionsAlpha()
                    self.startAnimating()
                }
            }
            
        }
    }
    
    public func stopAnimating() {
        isAnimating = false
    }
    
}
