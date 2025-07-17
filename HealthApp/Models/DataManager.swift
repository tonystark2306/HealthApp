//
//  DataManager.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/17/25.
//

import Foundation
import Combine

class UserDataManager: ObservableObject {
    static let shared = UserDataManager()
    
    @Published var profiles: [UserData] = []
    
    private init() {}
    
    func addProfile(_ userData: UserData) {
        profiles.append(userData)
    }
    
    func updateProfile(_ userData: UserData) {
        if let index = profiles.firstIndex(where: { $0.id == userData.id }) {
            profiles[index] = userData
        }
    }
    
    func deleteProfile(_ profileId: UUID) {
        profiles.removeAll { $0.id == profileId }
    }
    
    func getProfile(by id: UUID) -> UserData? {
        return profiles.first { $0.id == id }
    }
}
