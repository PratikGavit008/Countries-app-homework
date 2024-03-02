//
//  CountriesViewCoordinator.swift
//  Countries
//
//  Created by Pratik Gavit on 02/03/24.
//

import UIKit

protocol CountriesViewCoordinatorDelegate: AnyObject {
    
}

class CountriesViewCoordinator: Coordinator, CountriesViewCoordinatorDelegate {
    var childCoordinator = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CountriesViewController.instantiate()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
}
