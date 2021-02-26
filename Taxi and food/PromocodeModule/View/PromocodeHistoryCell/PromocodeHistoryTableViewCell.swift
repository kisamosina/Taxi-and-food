//
//  PromocodeHistoryTableViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeHistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var expirationImageView: UIImageView!
    
    @IBOutlet weak var expirationLabel: UILabel!
    
    @IBOutlet weak var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        
        self.parentView.layer.cornerRadius = PromocodeHistoryCellViewLayer.cornerRadius.rawValue
        self.parentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.parentView.layer.shadowOpacity = Float(PromocodeHistoryCellViewLayer.shadowOpacity.rawValue)
        self.parentView.layer.shadowRadius = PromocodeHistoryCellViewLayer.shadowRadius.rawValue
        self.parentView.layer.shadowOffset = CGSize(width: PromocodeHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue,
                                         height: PromocodeHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue)
        self.parentView.layer.masksToBounds = false
    }
    
    
    func setupCell(with data: PromocodeHistoryData, vcState: PromocodeHistoryViewControllerStates) {
        self.codeLabel.text = data.code
        self.descriptionLabel.text = data.shortDescription
        self.expirationImageView.image = UIImage(named: CustomImagesNames.promocodeExpire.rawValue)
        self.setExpirationLabelTextAndImage(data: data, vcState: vcState)
    }
    
    private func setExpirationLabelTextAndImage(data: PromocodeHistoryData, vcState: PromocodeHistoryViewControllerStates) {
        
        guard let activationDate = data.dateActivation.iso8601withFractionalSeconds  else { return }
        let expiredDate = activationDate + TimeInterval(data.validity)
        let dateFormatter = DateFormatter()
        let dateString = dateFormatter.getDateWithPoints(date: expiredDate)
        
        switch vcState {
        
        case .active:
            self.expirationLabel.text = PromocodeHistoryCellTexts.expireAfterText + dateString
            self.expirationImageView.image = UIImage(named: CustomImagesNames.promocodeExpire.rawValue)
        case .expired:
            
            if data.used {
                self.expirationLabel.text = PromocodeHistoryCellTexts.activatedText + dateString
                self.expirationImageView.image = UIImage(named: CustomImagesNames.pomocodeActivated.rawValue)
            } else {
                self.expirationLabel.text = PromocodeHistoryCellTexts.expiredText + dateString
                self.expirationImageView.image = UIImage(named: CustomImagesNames.promocodeExpired.rawValue)
            }
            
        }
        
        self.expirationLabel.setBold(dateString)
    }
}
