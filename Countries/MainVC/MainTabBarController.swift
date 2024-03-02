//
//  CustomTabBarController.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    var country = ""
    
    let countriesCoordinator = CountriesViewCoordinator(navigationController: UINavigationController())
    let savedViewCoordinator = SavedViewCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeCoordinators()
        assignViewcontroller()
    }
  
    func intializeCoordinators() {
        countriesCoordinator.start()
        savedViewCoordinator.start()
    }
    
    func assignViewcontroller() {
        viewControllers = [
            self.countriesCoordinator.navigationController,
            self.savedViewCoordinator.navigationController
        ]
    }

}
