//
//  MapViewController.swift
//  Countries
//
//  Created by Pratik Gavit on 25/12/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var MapDetails: DetailsModel?
    var temp:MKCoordinateRegion?
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblRegionDesc: UILabel!
    @IBOutlet weak var lblSubRegionDesc: UILabel!
    @IBOutlet weak var lblCapitalDesc: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imgView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornerRad(view: view1)
//        imgBorder(img: imgFlag)

        imgView.layer.borderColor = UIColor.gray.cgColor;
        imgView.layer.borderWidth = 0.5;
    
        setupUI()
        print(MapDetails as Any)
        getCountry(name: MapDetails?.name?.common?.uppercased() ?? "INDIA")
    }
    
    func setupUI(){
        //Getting data from another tab
        let tabBar = tabBarController as? DetailTabBarCobtroller
        MapDetails = tabBar!.mapdata
        
        imgFlag.kf.setImage(with: URL(string: MapDetails?.flags?.png ?? ""))
        lblCountryName.text = "Country - \(MapDetails?.name?.common ?? "")"
        lblRegionDesc.text = MapDetails?.region
        lblSubRegionDesc.text = MapDetails?.subregion
        lblCapitalDesc.text = MapDetails?.capital?.first
    }
 
    func SetRegion(){
        mapView.setRegion(temp!, animated: true)
    }
    
    
    func getCountry(name:String)  {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            if let response = response{
                print(response)
                DispatchQueue.main.async {
                    self.temp = response.boundingRegion
                    self.SetRegion()
                }

            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
            }
        }
    }
}




//----- for further Use 👇

//func mapConfig(){
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 37.2, longitude: 22.9), animated: true)
//        mapView.region.span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
//        let pin = MKPointAnnotation()
//        pin.coordinate = CLLocationCoordinate2D(latitude: 37.2, longitude: 22.9)
//        mapView.addAnnotation(pin)
    
//}

