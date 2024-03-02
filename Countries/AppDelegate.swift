//
//  AppDelegate.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    var coordinator:MainCoordinator?
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        setRootVC(storyboard: "Main", vc: "MainTabBarController")
//        let navigationController = UINavigationController()
//        coordinator = MainCoordinator(navigationController: navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
//        coordinator?.start()
        return true
    }
}

extension AppDelegate {
    func setRootVC(storyboard: String, vc: String) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let navVC = storyboard.instantiateViewController(identifier: vc)
        as? UITabBarController
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
   
}

