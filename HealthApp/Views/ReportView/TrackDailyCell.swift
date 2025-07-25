//
//  TrackDailyCell.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/25/25.
//

import UIKit

class TrackDailyCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
