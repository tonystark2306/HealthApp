//
//  UserData.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/16/25.
//

import Foundation

struct UserData: Equatable {
    let id: UUID
    var firstName: String
    var lastName: String
    var weight: String
    var height: String
    var gender: String
    
    init(firstName: String, lastName: String, weight: String, height: String, gender: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.gender = gender
    }
    
    init(id: UUID, firstName: String, lastName: String, weight: String, height: String, gender: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.gender = gender
    }
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.id == rhs.id
    }
}

