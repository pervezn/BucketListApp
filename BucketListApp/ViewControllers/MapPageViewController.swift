//
//  MapPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import GooglePlaces
import GooglePlacePicker

//enum searchType {
//    case nearbySearch, textSearch, radarSearch, placeAutocomplete, queryAutocomplete
//
//}
//
//enum parameters {
//    case root
//    case
//    case key(key: String)
//    
//    
//    
//    , location, radius, rankby, query, keyword, name, opennow, type
//}

class MapPageViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
     var placesClient: GMSPlacesClient!
    let url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=landmarks+in+chicago&key=AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.888543, -87.635444)
       // let initialLocation = CLLocation(latitude: 41.888543, longitude: -87.635444) //change this to the person's initial location
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Hello there!"
        mapView.addAnnotation(annotation)
        
        
        
        
        Alamofire.request(url).validate().responseJSON() { response in
            
            //print(response.result.value)
            let info = JSON(response.result.value)
            
            let placesArray = info["results"].arrayValue
            
            for place in placesArray {
                let newPlace = Places(json: place)
            }
            print(placesArray)
        }
        
       
        
       // centerMapOnLocation(location: location) //right when you open the map it will go to this initial location
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
