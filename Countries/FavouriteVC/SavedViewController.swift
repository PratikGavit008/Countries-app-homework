//
//  FavouriteViewController.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit


class SavedViewController: UIViewController {
    var DefaultDataCheck:[String] = []
    var SavedCountries:[DetailsModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromDefault()
        print(DefaultDataCheck.count)
        getCountryList()
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataFromDefault()
    }
    func getDataFromDefault(){
        let defaults = UserDefaults.standard
        if let stringOne = defaults.object(forKey: DefaultsKeys.keyOne) as? [String] {
            DefaultDataCheck.append(contentsOf: stringOne)
        }
    }
    
//    func getDatafromLocal(){
//        let defaults = UserDefaults.standard
//        if let stringOne = defaults.object(forKey: DefaultsKeys.keyOne) {
//            print("ergvdf",stringOne)
//            // Some String Value
//        }
//        if let stringTwo = defaults.string(forKey: DefaultsKeys.keyTwo) {
//            print("dfhjdfgjhfgdjh",stringTwo) // Another String Value
//        }
//    }
    func getCountryList(){
        for i in 0...DefaultDataCheck.count - 1{
            getCountry(country: DefaultDataCheck[i])
        }
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
                            self.SavedCountries = decodedData
                            self.tableView.reloadData()
                            
                            //                        self.updateUI()
                            //                        self.passToTabBar()
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
        return cell
    }
}
