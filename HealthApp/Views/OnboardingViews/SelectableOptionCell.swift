//
//  SelectableOptionCell.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/23/25.
//

import UIKit
class SelectableOptionCell: UICollectionViewCell {

    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        updateAppearance(isSelected: false)
    }

    func configure(title: String, imageName: String, isSelected: Bool) {
        titleLabel.text = title
        iconImageView.image = UIImage(named: imageName)
        updateAppearance(isSelected: isSelected)
    }

    private func updateAppearance(isSelected: Bool) {
        if isSelected {
            containerView.layer.borderWidth = 1.5
            containerView.layer.borderColor = UIColor.primary1.cgColor
            checkboxImageView.image = UIImage(named: "tickSquare")
            checkboxImageView.tintColor = UIColor(red: 1.0, green: 0.33, blue: 0.45, alpha: 1.0)
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = UIColor.white.cgColor
            containerView.backgroundColor = .white
            checkboxImageView.image = UIImage(named: "emptyTick")
            checkboxImageView.tintColor = .systemGray3
            checkboxImageView.backgroundColor = UIColor(named: "Neutral4")
        }
    }
}
