//
//  Coordinator.swift
//  Countries
//
//  Created by Pratik Gavit on 02/03/24.
//

import UIKit

protocol Coordinator:AnyObject {
    var childCoordinator:[Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
