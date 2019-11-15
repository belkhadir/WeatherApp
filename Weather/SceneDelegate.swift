//
//  SceneDelegate.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let windowScene = scene as? UIWindowScene {
            
            if !isFirstTimeOpen {
                addDefaultCityToCoreData()
                UserDefaults.standard.set(true, forKey: "isFirstTimeOpen")
            }
            
            
            let window = UIWindow(windowScene: windowScene)
            let cityTableViewController = UINavigationController(rootViewController: CityTableViewController(style: .grouped))
            window.rootViewController = cityTableViewController
            
            self.window = window
            window.makeKeyAndVisible()
        }

    }

    var isFirstTimeOpen: Bool {
        return UserDefaults.standard.bool(forKey: "isFirstTimeOpen")
    }
}

