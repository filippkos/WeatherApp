//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Filipp Kosenko on 19.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Variables

    let window = UIWindow()
    
    // MARK: -
    // MARK: Internal

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.prepareRootController()
        
        return true
    }
    
    private func prepareRootController() {
        let navigationController = UINavigationController()
        let coordinator = Coordinator(navigationController: navigationController)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

