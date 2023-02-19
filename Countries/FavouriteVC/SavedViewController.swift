//
//  FavouriteViewController.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit


class SavedViewController: UIViewController {
    var SavedCountries:[DetailsModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    override func viewWillAppear(_ animated: Bool) {
        getCountryList()
    }
    func getDataFromDefault()->String{
        let defaults = UserDefaults.standard
       let country = defaults.value(forKey: "country") as! String
        return country
    }
    
    func getCountryList(){
        getCountry(country: getDataFromDefault())
        
    }
    
    
    
    func getCountry(country:String){
        let temp = country.components(separatedBy: .whitespaces).first!
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
                            self.SavedCountries.append(contentsOf: decodedData)
                            print(self.SavedCountries)
                            self.tableView.reloadData()
                        }
                    }
                    
                }
            }
        }.resume()
    }
    
}

extension SavedViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FavouriteCountriesCell
        else { fatalError() }
        cell.imgFlag.kf.setImage(with:URL(string: SavedCountries[indexPath.row].flags?.png ?? "") )
        cell.lblCountryName.text = SavedCountries[indexPath.row].name?.common
        return cell
    }
}
