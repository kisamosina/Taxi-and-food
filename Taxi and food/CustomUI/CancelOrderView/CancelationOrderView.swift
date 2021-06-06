//
//  CancelationOrderView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class CancelationOrderView: CustomBottomView {
    
    private var cancelationReasons: [String] {
        CancelationOrderViewTexts.cancelationReasons
    }
    
    weak var delegate: CancelationOrderViewDelegate?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var cancelationReasonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    // MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        loadFromNib(nibName: String(describing: CancelationOrderView.self))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.backgroundColor = .clear
        setupConstraints()
        cancelationReasonLabel.text = CancelationOrderViewTexts.cancelationReasonHeader
        let nib = UINib(nibName: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue)
        tableView.tableFooterView = UIView()
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

extension CancelationOrderView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cancelationReasons.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodSubCategoriesViewStringData.tableViewCellReuseId.rawValue) as? FoodSubCategoryCell
        else { return UITableViewCell() }
        cell.bind(subcategoryTitle: cancelationReasons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reason = cancelationReasons[indexPath.row]
        delegate?.reasonSelected(reason: reason)
    }
}
