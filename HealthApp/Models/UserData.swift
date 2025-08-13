//
//  UserData.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/16/25.
//

import Foundation
import RealmSwift

class UserData: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var weight: String = ""
    @Persisted var height: String = ""
    @Persisted var gender: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(firstName: String, lastName: String, weight: String, height: String, gender: String) {
        self.init()
        self.id = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.gender = gender
    }
    
    convenience init(id: String, firstName: String, lastName: String, weight: String, height: String, gender: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.gender = gender
    }
}

extension UserData {
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.id == rhs.id
    }
}
