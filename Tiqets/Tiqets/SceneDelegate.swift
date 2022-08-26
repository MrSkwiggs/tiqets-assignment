//
//  SceneDelegate.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
        #if DEBUG
        let viewModelProvider = ViewModelProvider(root: .debug)
        #else
        let viewModelProvider = ViewModelProvider(root: .main)
        #endif
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootView = RootView()
                .environmentObject(viewModelProvider)
            window.rootViewController = UIHostingController(rootView: rootView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
