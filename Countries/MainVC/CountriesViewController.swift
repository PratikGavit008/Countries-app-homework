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
        setupUI()
        loadTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func loader() -> UIAlertController {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.large
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            return alert
        }
        
        func stopLoader(loader : UIAlertController) {
            DispatchQueue.main.async {
                loader.dismiss(animated: true, completion: nil)
            }
        }
    
    func loadTable(){
        let loader = loader()
        ApiManager.shared.getCountriesList { responce in
            stopLoader(loader: loader)
            switch responce{
            case .success(let countries):
                DispatchQueue.global(qos: .userInitiated).sync {
                    let sorted = countries.sorted(by: { ($0.name?.common)! < ($1.name?.common)! })
                    self.countries.append(contentsOf: sorted)
                    print(self.countries.count)
                }
                print("Started")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("Ended")
//                DispatchQueue.global(qos: .userInteractive).async {
//                    self.tableView.reloadData()
//                }
                
            case .failure(let err):
                print(err)
            }
        }
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
        let processor = DownsamplingImageProcessor(size: cell.imgFlag.bounds.size)

        if searching {
            
            cell.imgFlag.kf.setImage(
                with: URL(string: filterArr[indexPath.row].flags?.png ?? ""),
                placeholder: UIImage(systemName: "ticket"),
                options: [
                    
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
            
            cell.imgFlag.kf.indicatorType = .activity
            //            cell.imgFlag.kf.setImage(with: URL(string: filterArr[indexPath.row].flags?.png ?? "") )
            cell.lblCountryName.text = filterArr[indexPath.row].name?.common
            cell.lblCountryDetail.text = filterArr[indexPath.row].name?.official
            cell.lblCapital.text = filterArr[indexPath.row].capital?.first
        }
        else {
            
            cell.imgFlag.kf.setImage(
                with: URL(string: countries[indexPath.row].flags?.png ?? ""),
                placeholder: UIImage(systemName: "ticket"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),

                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
         
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



//Old api call new onw is in network manager

//        guard let url = URL(string: Constants.Api.countriesUrl) else {return}
//                URLSession.shared.dataTask(with: url) { data, responce, error in
//                    if let error = error {print(error.localizedDescription)}
//
//                    if responce != nil {
//                        if let data = data {
//                            let decoder = JSONDecoder()
//                            let decodedData = try? decoder.decode([CountryModel].self, from: data)
//                            print(data)
//                            DispatchQueue.main.async {
//                                if let decodedData = decodedData {
//                                    let sorted = decodedData.sorted(by: { ($0.name?.common)! < ($1.name?.common)! })
//
//                                    self.countries.append(contentsOf: sorted)
//                                    self.tableView.reloadData()
//                                }
//                            }
//
//                        }
//                    }
//                }.resume()

