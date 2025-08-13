//
//  UserDataManager.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/17/25.
//

import Foundation
import RealmSwift

class UserDataManager {
    static let shared = UserDataManager()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed: \(error)")
        }
    }
    
    var currentUserData: UserData? {
        get {
            return realm.objects(UserData.self).first
        }
        set {
            do {
                try realm.write {
                    if let userData = newValue {
                        realm.add(userData, update: .modified)
                    } else {
                        let allUsers = realm.objects(UserData.self)
                        realm.delete(allUsers)
                    }
                }
            } catch {
                print("Error save: \(error)")
            }
        }
    }
    
    func hasUserData() -> Bool {
        return currentUserData != nil
    }
    
    func saveUserData(_ userData: UserData) {
        do {
            try realm.write {
                realm.add(userData, update: .modified)
            }
        } catch {
            print("Error save: \(error)")
        }
    }
    
    func deleteUserData() {
        do {
            try realm.write {
                let allUsers = realm.objects(UserData.self)
                realm.delete(allUsers)
            }
        } catch {
            print("Error delete: \(error)")
        }
    }
}
