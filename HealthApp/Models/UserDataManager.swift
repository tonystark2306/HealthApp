//
//  UserDataManager.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/17/25.
//
import Foundation

// MARK: - UserDataManager
class UserDataManager {
    static let shared = UserDataManager()
    
    private let userDefaults = UserDefaults.standard
    private let userDataKey = "SavedUserData"
    
    private init() {}
    
    var currentUserData: UserData? {
        get {
            guard let data = userDefaults.data(forKey: userDataKey) else {
                return nil
            }
            
            do {
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                return userData
            } catch {
                print("Error decoding user data: \(error)")
                // Xóa dữ liệu bị lỗi
                userDefaults.removeObject(forKey: userDataKey)
                return nil
            }
        }
        set {
            if let userData = newValue {
                do {
                    let data = try JSONEncoder().encode(userData)
                    userDefaults.set(data, forKey: userDataKey)
                } catch {
                    print("Error encoding user data: \(error)")
                }
            } else {
                userDefaults.removeObject(forKey: userDataKey)
            }
        }
    }
    
    func hasUserData() -> Bool {
        return currentUserData != nil
    }
    
    func saveUserData(_ userData: UserData) {
        currentUserData = userData
    }
    
    func deleteUserData() {
        currentUserData = nil
    }
    
    func updateUserData(_ updatedData: UserData) {
        guard let existingData = currentUserData,
              existingData.id == updatedData.id else {
            // If no existing data or different ID, save as new
            saveUserData(updatedData)
            return
        }
        
        // Update existing data
        currentUserData = updatedData
    }
}

// MARK: - UserData Codable Extension
extension UserData: Codable {
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, weight, height, gender
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        weight = try container.decode(String.self, forKey: .weight)
        height = try container.decode(String.self, forKey: .height)
        gender = try container.decode(String.self, forKey: .gender)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(weight, forKey: .weight)
        try container.encode(height, forKey: .height)
        try container.encode(gender, forKey: .gender)
    }
}
