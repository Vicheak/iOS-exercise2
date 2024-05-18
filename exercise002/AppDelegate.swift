//
//  AppDelegate.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginScreenViewController = LoginScreenViewController()
        
        window?.rootViewController = loginScreenViewController
        window?.makeKeyAndVisible()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .systemOrange
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarAppearance.shadowColor = .black
        
        let navigationBarScrollAppearance = UINavigationBarAppearance()
        navigationBarScrollAppearance.configureWithDefaultBackground()
        navigationBarScrollAppearance.backgroundColor = .systemYellow
        navigationBarScrollAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarScrollAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarScrollAppearance.shadowColor = .black
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .systemOrange
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarScrollAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        return true
    }

}

