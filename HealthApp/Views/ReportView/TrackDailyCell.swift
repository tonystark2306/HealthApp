//
//  TrackDailyCell.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/25/25.
//

import UIKit

class TrackDailyCell: UITableViewCell {

    @IBOutlet weak var trackDailyText: UILabel!
    @IBOutlet weak var clickText: UILabel!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16
        if let text = clickText.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.kern, value: 0.4, range: NSRange(location: 0, length: text.count))
            clickText.attributedText = attributedString
        }
        
        if let text2 = trackDailyText.text {
            let attributedString = NSMutableAttributedString(string: text2)
            attributedString.addAttribute(.kern, value: 0.2, range: NSRange(location: 0, length: text2.count))
            trackDailyText.attributedText = attributedString
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
