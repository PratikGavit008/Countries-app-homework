//
//  ViewController.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit
import Kingfisher

class CountriesViewController: UIViewController {
    
    var countries: [CountryModel] = []
    var searching = false
    var filterArr: [CountryModel] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getCountriesList()
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCountriesList(){
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {print(error.localizedDescription)}
            
            if responce != nil {
                if let data = data {
                    let decoder = JSONDecoder()
                    let decodedData = try? decoder.decode([CountryModel].self, from: data)
                    print(data)
                    DispatchQueue.main.async {
                        if let decodedData = decodedData {
                            let sorted = decodedData.sorted(by: { ($0.name?.common)! < ($1.name?.common)! })
                    
                            self.countries.append(contentsOf: sorted)
                            self.tableView.reloadData()
                        }
                    }
                    
                }
            }
        }.resume()
    }
 
  
    
}

extension CountriesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           
            return filterArr.count
           
        } else {
            return countries.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CountriesCell
        else { fatalError() }
        
        if searching {
            
            cell.imgFlag.kf.setImage(with: URL(string: filterArr[indexPath.row].flags?.png ?? "") )
            cell.lblCountryName.text = filterArr[indexPath.row].name?.common
            cell.lblCountryDetail.text = filterArr[indexPath.row].name?.official
            cell.lblCapital.text = filterArr[indexPath.row].capital?.first
        }
        else {
           
            cell.imgFlag.kf.setImage(with: URL(string: countries[indexPath.row].flags?.png ?? ""))
            cell.lblCountryName.text = countries[indexPath.row].name?.common
            cell.lblCountryDetail.text = countries[indexPath.row].name?.official
            cell.lblCapital.text = countries[indexPath.row].capital?.first
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            if searching{
                let destination = segue.destination as? DetailTabBarCobtroller
                let name = filterArr[(sender as? Int)!].name?.common
                print("sender\(sender as? Int ?? 0),name\(name ?? "")")
                destination?.CountryName = name!
                destination?.navigationItem.title = name!
               
            } else{
                let destination = segue.destination as? DetailTabBarCobtroller
                let name = countries[(sender as? Int)!].name?.common
                print("sender\(sender as? Int ?? 0),name\(name ?? "")")
                destination?.CountryName = name!
                destination?.navigationItem.title = name!
                
         
            }
        }
        self.tabBarController?.tabBar.isHidden = true
        
    }
}

extension CountriesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArr = countries.filter{$0.name?.common?.prefix(searchText.count) ?? "" == searchText}
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}


