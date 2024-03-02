//
//  SavedViewCoordinator.swift
//  Countries
//
//  Created by Pratik Gavit on 02/03/24.
//

import UIKit

protocol SavedViewCoordinatorDelegate: AnyObject {
    
}

class SavedViewCoordinator: Coordinator, SavedViewCoordinatorDelegate {
    var childCoordinator: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SavedViewController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "star.fill"), tag: 1)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    
}
