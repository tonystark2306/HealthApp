//
//  LogCell.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

class LogCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pulseValue: UILabel!
    
    @IBOutlet weak var bpmPulse: UILabel!
    
    @IBOutlet weak var hrvValue: UILabel!
    
    @IBOutlet weak var bpmHrv: UILabel!
    
    @IBOutlet weak var statusValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupContainerView() {
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with log: HealthLog) {
        setupContainerView()
        pulseValue.text = "\(log.pulse)"
        pulseValue.textColor = log.statusColor
        hrvValue.text = "\(log.hrv)"
        hrvValue.textColor = log.statusColor
        statusValue.text = log.status
        statusValue.textColor = log.statusColor
        bpmHrv.textColor = log.statusColor
        bpmPulse.textColor = log.statusColor
    }

    func configureEmpty() {
        setupContainerView()
        pulseValue.text = "--"
        hrvValue.text = "--"
        statusValue.text = "--"
        bpmPulse.text = "bpm"
        bpmHrv.text = "bpm"
        pulseValue.textColor = .neutral22
        hrvValue.textColor = .neutral22
        statusValue.textColor = .neutral22
        bpmPulse.textColor = .neutral22
        bpmHrv.textColor = .neutral22
    }
    
}
