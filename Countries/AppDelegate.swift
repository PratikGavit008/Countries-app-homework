//
//  AppDelegate.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC(storyboard: "Main", vc: "MainNavVc")
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

