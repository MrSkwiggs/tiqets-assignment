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
        let viewModelProvider = ViewModelProvider(root: .debug())
        
        // Uncomment for fake network delays
//        let viewModelProvider = ViewModelProvider(root: .mock)
        
        // Uncomment for fake network failure
//        let viewModelProvider = ViewModelProvider(root: .debug(failingNetwork: true))
        
        #else
        let viewModelProvider = ViewModelProvider(root: .main)
        #endif
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootView = RootView(viewModel: viewModelProvider.rootViewModel)
                .environmentObject(viewModelProvider)
            window.rootViewController = UIHostingController(rootView: rootView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
