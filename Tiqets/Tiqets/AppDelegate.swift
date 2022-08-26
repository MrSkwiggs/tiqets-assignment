//
//  AppDelegate.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if connectingSceneSession.role == UISceneSession.Role.windowApplication {
            let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            config.delegateClass = SceneDelegate.self
            return config
        }
        fatalError("Unhandled scene role \(connectingSceneSession.role)")
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("hello")
    }
}
