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
        var newArray = [String]() //2.create a new array and assign the UserDefault array1 here
        
        var defaults = UserDefaults.standard
        
        let savedArray = defaults.object(forKey: DefaultsKeys.keyOne) as? [String]
        if let savedArray = defaults.object(forKey: DefaultsKeys.keyOne) as? [String] {//1.this is protected cannot update directly
            
            let savedValue: String = CountryName //3. the value you wanted to append
            
            newArray = savedArray //4. just copying the value here
            
            newArray.append(savedValue) //5. appending the new value
        }
        defaults.set(newArray, forKey: DefaultsKeys.keyOne) //6. now the value "name" is saved.
        
        
        
        //
        //        let defaults = UserDefaults.standard
        //        var array = [String]()
        //        defaults.set(CountryName, forKey: DefaultsKeys.keyOne)
    }
    
}
