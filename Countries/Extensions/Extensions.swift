//
//  Extensions.swift
//  Countries
//
//  Created by Pratik Gavit on 25/01/23.
//

import UIKit

extension UIView {
    private struct ActivityIndicator {
        static var container: UIView?
        static var activityIndicator: UIActivityIndicatorView?
        static var backgroundView: UIVisualEffectView?
    }
    
    func startActivityIndicator() {
        if ActivityIndicator.container != nil {
            return
        }
        
        // Create a container view that covers the entire view
        let container = UIView(frame: self.bounds)
        container.backgroundColor = .clear
        
        // Create a blur effect view to use as the background
        let blurEffect = UIBlurEffect(style: .light)
        let backgroundView = UIVisualEffectView(effect: blurEffect)
        backgroundView.frame = container.bounds
        container.addSubview(backgroundView)
        
        // Create the activity indicator and center it in the container
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = container.center
        container.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // Add the container to the view hierarchy
        self.addSubview(container)
        ActivityIndicator.container = container
        ActivityIndicator.activityIndicator = activityIndicator
        ActivityIndicator.backgroundView = backgroundView
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            guard let container = ActivityIndicator.container,
                  let backgroundView = ActivityIndicator.backgroundView,
                  let activityIndicator = ActivityIndicator.activityIndicator else {
                return
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                backgroundView.alpha = 0
                activityIndicator.alpha = 0
            }, completion: { _ in
                container.removeFromSuperview()
                ActivityIndicator.container = nil
                ActivityIndicator.activityIndicator = nil
                ActivityIndicator.backgroundView = nil
            })
        }
        
    }
}

