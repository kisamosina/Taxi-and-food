//
//  TextEnterView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TextEnterViewDelegate: class {
    func approveButtonTapped(_ text: String)
}

class TextEnterView: UIView {
    
    weak var delegate: TextEnterViewDelegate?
    
    var upView: UIView = {
        let rect = CGRect(x: 0,
                          y: 0,
                          width: TextEnterViewUpperViewData.width.rawValue,
                          height: TextEnterViewUpperViewData.height.rawValue)
        let view = UIView(frame: rect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.InactiveViewColor.getColor()
        return view
    }()
    
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.becomeFirstResponder()
        return tf
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.redTextColor.getColor()
        label.font = .systemFont(ofSize: TextEnterViewFontSizes.labelFontSize.rawValue)
        return label
    }()
    
    var button: MainBottomButton = {
        let button = MainBottomButton()
        button.setupAs(.approve)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainView.layer.cornerRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.mainView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.mainView.layer.shadowOpacity = Float(MapBottomViewUIData.shadowOpacity.rawValue)
        self.mainView.layer.shadowRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.mainView.layer.shadowOffset = CGSize(width: MapBottomViewUIData.shadowOffsetWidth.rawValue,
                                                  height: MapBottomViewUIData.shadowOffsetWidth.rawValue)
        self.mainView.layer.masksToBounds = false
        self.upView.layer.cornerRadius = TextEnterViewConstraints.upViewHeight.rawValue / 2
        self.upView.clipsToBounds = true
        textField.addBottomBorder(color: Colors.buttonGrey.getColor())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupSubviews()
        self.textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        for view in [upView, mainView] {
            self.addSubview(view)
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 26))
        view.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let innerStackView = UIStackView(arrangedSubviews: [textField, view, button], axis: .vertical, spacing: 0)
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(innerStackView)
        
        NSLayoutConstraint.activate([
            self.upView.topAnchor.constraint(equalTo: self.topAnchor),
            self.upView.heightAnchor.constraint(equalToConstant: TextEnterViewConstraints.upViewHeight.rawValue),
            self.upView.widthAnchor.constraint(equalToConstant: TextEnterViewConstraints.upViewWidth.rawValue),
            self.upView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mainView.topAnchor.constraint(equalTo: upView.topAnchor, constant: TextEnterViewStackViewData.mainStackSpacing.rawValue),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            innerStackView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: TextEnterViewConstraints.innerStackViewTopAnchor.rawValue),
            innerStackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: TextEnterViewConstraints.innerViewLeadingAnchor.rawValue),
            innerStackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: TextEnterViewConstraints.innerViewTrailingAndBottomAnchor.rawValue),
            textField.leadingAnchor.constraint(equalTo: innerStackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: innerStackView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: MainButtonSizes.height.rawValue),
            button.leadingAnchor.constraint(equalTo: innerStackView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: innerStackView.trailingAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        guard let text = textField.text, text != "" else { return }
        self.delegate?.approveButtonTapped(text)
    }
    
    @objc func textFieldTextChanged() {
        self.label.isHidden = true
        self.button.setActive()
    }
}

