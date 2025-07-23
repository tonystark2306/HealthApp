//
//  SettingCell.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/18/25.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with item: SettingVC.SettingsItem, isFirstCell: Bool, isLastCell: Bool, isOnlyCell: Bool) {
        titleLabel.text = item.title
        iconImageView.image = UIImage(named: item.icon)
        iconImageView.tintColor = item.iconColor
        
        if isOnlyCell {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if isFirstCell {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLastCell {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            containerView.layer.cornerRadius = 0
            containerView.layer.maskedCorners = []
        }
        
        if !isLastCell && !isOnlyCell {
            addSeparatorLine()
        } else {
            removeSeparatorLine()
        }
    }
    
    private func addSeparatorLine() {

        containerView.layer.sublayers?.removeAll { $0.name == "separator" }
        
        let separator = CALayer()
        separator.name = "separator"
        separator.backgroundColor = UIColor.accentLine.cgColor
        containerView.layer.addSublayer(separator)

        updateSeparatorFrame()
    }
    
    private func removeSeparatorLine() {
        containerView.layer.sublayers?.removeAll { $0.name == "separator" }
    }
    
    private func updateSeparatorFrame() {
        if let separator = containerView.layer.sublayers?.first(where: { $0.name == "separator" }) {
            separator.frame = CGRect(
                x: 45, 
                y: containerView.bounds.height - 0.5,
                width: containerView.bounds.width - 55,
                height: 1
            )
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSeparatorFrame()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.1) {
            self.containerView.backgroundColor = highlighted ? UIColor.systemGray6 : UIColor.white
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeSeparatorLine()
        containerView.layer.cornerRadius = 0
        containerView.layer.maskedCorners = []
        containerView.backgroundColor = .white
    }
}
