//
//  DetailViewController.swift
//  Countries
//
//  Created by Pratik Gavit on 25/12/22.
//

import UIKit

class DetailViewController: UIViewController {
    var DetailCountries: DetailsModel?
    var countryName:String = ""
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblRegionDesc: UILabel!
    @IBOutlet weak var lblSubRegionDesc: UILabel!
    @IBOutlet weak var lblCapitalDesc: UILabel!
    @IBOutlet weak var lblTimeZoneDesc: UILabel!
    @IBOutlet weak var lblPopulationDesc: UILabel!
    @IBOutlet weak var lblLangDesc: UILabel!
    @IBOutlet weak var lblCurrenciesDesc: UILabel!
    @IBOutlet weak var lblCarSideDesc: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var imgCoatOfArms: UIImageView!
    
    @IBOutlet weak var imgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Object of tabBarController
        let tabBarVC = tabBarController as! DetailTabBarCobtroller
        countryName = tabBarVC.CountryName
        getCountry()
        
                
    }
    
    
    func passToTabBar(){
        let tabBarVC = tabBarController as! DetailTabBarCobtroller
        tabBarVC.mapdata = DetailCountries
    }
    
    func setupUI(){
        addCornerRad(view: view1)
        addCornerRad(view: view2)
        addCornerRad(view: view3)
        addCornerRad(view: view4)
        addCornerRad(view: view5)
        addCornerRad(view: view6)
        addCornerRad(view: view7)
        
        imgBorder(img: imgCoatOfArms)
        imgView.layer.borderColor = UIColor.gray.cgColor;
        imgView.layer.borderWidth = 0.5;
    }
    
    func updateUI(){
        lblRegionDesc.text = DetailCountries?.region
        lblSubRegionDesc.text = DetailCountries?.subregion
        lblCapitalDesc.text = DetailCountries?.capital?.first
        lblTimeZoneDesc.text = DetailCountries?.timezones?.first
        lblPopulationDesc.text = String(describing: DetailCountries!.population!)
        lblLangDesc.text = "\(DetailCountries?.languages?.eng ?? "")" + "" + "\(DetailCountries?.languages?.smo ?? "")"
        lblCurrenciesDesc.text = "\(DetailCountries?.currencies?.uSD?.name ?? "")" + "" + "\(DetailCountries?.currencies?.uSD?.symbol ?? "")"
        lblCarSideDesc.text = DetailCountries?.car?.side
        
        imgFlag.kf.setImage(with: URL(string: DetailCountries?.flags?.png ?? ""))
        imgCoatOfArms.kf.setImage(with: URL(string: DetailCountries?.coatOfArms?.png ?? ""))
        
    }
    
    
    
    func getCountry(){
        let temp = countryName.components(separatedBy: .whitespaces).first!
        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(temp)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {print(error.localizedDescription)}
            
            if responce != nil {
                if let data = data {
                    let decoder = JSONDecoder()
                    let decodedData = try? decoder.decode([DetailsModel].self, from: data)
                    print(data)
                    DispatchQueue.main.async {
                        if let decodedData = decodedData {
                            self.DetailCountries = decodedData.first
//                            print(self.DetailCountries as DetailsModel? )
                            
                            self.updateUI()
                            self.passToTabBar()
                        }
                    }
                    
                }
            }
        }.resume()
    }
  
}

func addCornerRad(view:UIView){
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = true;
    

   
    view.layer.contentsScale = UIScreen.main.scale;
    view.layer.shadowColor = UIColor.black.cgColor;
    view.layer.shadowOffset = CGSize(width: 0, height: 5)
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOpacity = 0.5;
    view.layer.masksToBounds = false;
    view.clipsToBounds = false
}

func imgBorder(img:UIImageView){
    img.layer.masksToBounds = true
    img.layer.borderWidth = 0.5
    img.layer.borderColor = UIColor.gray.cgColor
}


