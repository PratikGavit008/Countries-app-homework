//
//  DetailTabBarCobtroller.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit

class DetailTabBarCobtroller: UITabBarController {

    var CountryName:String = ""
    var mapdata:DetailsModel?
    var savedData:CountryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
       
    }
    
    
    
    @objc func rightButtonAction(sender: Any){
        let defaults = UserDefaults.standard
        defaults.set(CountryName, forKey: "country")
        print(CountryName)
    }
    
}
