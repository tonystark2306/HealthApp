//
//  HealthLog.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/24/25.
//

import UIKit
import RealmSwift

class HealthLog: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var pulse: Int = 0
    @Persisted var hrv: Int = 0
    @Persisted var createdAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(pulse: Int, hrv: Int) {
        self.init()
        self.id = UUID().uuidString
        self.pulse = pulse
        self.hrv = hrv
        self.createdAt = Date()
    }

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
