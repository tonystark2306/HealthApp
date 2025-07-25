//
//  SceneDelegate.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)

        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

        if hasSeenOnboarding {
            let homeVC = MainTabBarController()
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
        } else {
            let firstOnboarding = FirstOnboardingVC()
            window?.rootViewController = UINavigationController(rootViewController: firstOnboarding)
        }

        window?.makeKeyAndVisible()
    }
}

