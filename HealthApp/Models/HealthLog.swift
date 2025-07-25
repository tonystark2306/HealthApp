//
//  HealthLog.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit

struct HealthLog {
    let pulse: Int
    let hrv: Int

    var status: String {
        switch pulse {
        case ..<60: return "Low"
        case 60...100: return "Good"
        default: return "Warning"
        }
    }

    var statusColor: UIColor {
        switch status {
        case "Low": return UIColor.low
        case "Good": return UIColor.accentNormal
        case "Warning": return UIColor.warning
        default: return .systemGray
        }
    }
}

