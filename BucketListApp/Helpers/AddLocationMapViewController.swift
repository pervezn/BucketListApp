//
//  AddLocationMapViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/24/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import GooglePlaces
import GooglePlacePicker
import GooglePlacesSearchController
import FirebaseAuth
import FirebaseAuthUI
import Firebase
//import CoreLocation  //Reason 1
//import GoogleMaps
 

class AddLocationMapViewController: UIViewController

{

   let googleSearchPlacesAPIKey = "AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M"
    
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var locationName: UITextField! 
    @IBOutlet weak var locationAddress: UILabel!
    
   // var marker = GMSMarker() // Reason 1
    
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var addressText: String = "address"
    var long : Double = 0.0
    var lat : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = GooglePlacesSearchController(apiKey: googleSearchPlacesAPIKey, placeType: PlaceType.address)
      /*  if locationAddress.text != nil {
            print("1: contatines a value!")
        } else {
            print("1: does not caontain an Int")
        }
        if locationName.text != nil {
            print("2: contatines a value!")
        } else {
            print("2: does not caontain an Int")
        }*/
       // locationAddress.text = "address"
        //locationName.text = "name"
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
      
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
       // definesPresentationContext = true
        
        // Keep the navigation bar visible.
        
       controller.didSelectGooglePlace { (place) -> Void in
            //print(place.description)
            //print(place.formattedAddress)
            self.locationAddress.text = place.formattedAddress
          //  print("Place coordinate: \(place.coordinate)")
            self.lat = place.coordinate.latitude
            self.long = place.coordinate.longitude
        
        
        
           /* let position1 = place.coordinate
            self.marker = GMSMarker(position: position1)
            self.marker.title = place.name
            self.marker.map = self.locationMapView */
            //Reason1: This doesn't work becasue is uses a GMSMap instead of a mapkit
            
            
           controller.isActive = false
        }
        
        present(controller, animated:  true, completion: nil)
        // Do any additional setup after loading the view.
       
        
       /* let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude , zoom: 12)
        self.locationMapView.camera = camera! */ //Reason 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "unwindToNewCategoryTableViewController" {
        let current = Auth.auth().currentUser
        UserDefaults.standard.set(locationName.text, forKey: "locationName")
        
       // print("locationName.text is: \(locationName.text)")
       //print("locationAddress.text is: \(locationAddress.text)")
        
        UserDefaults.standard.set(locationAddress.text, forKey: "locationAddress")
            
        let place = Places(formatted_Address: locationAddress.text!, lat: lat, lng: long, name: locationName.text!)
            ListItemService.makeListItems(current!, catID: arrayOfCategories[arrayOfCategories.count-1].key, itemTitle: locationName.text!, address: locationAddress.text!, completion:  { (listItem) in
                arrayOfListItems2.append(listItem!)
            })
            print("arrayOfListItem2 is: \(arrayOfListItems2.count)")
        }
    }
    
        
   // }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddLocationMapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
      //  print("In the delegate")
        // Do something with the selected place.
       // print("Place bla name: \(place.name)")
       // print("Place address: \(place.formattedAddress)")
       // print("Place attributions: \(place.attributions)")
        
        addressText = place.formattedAddress!
        //print("\(locationAddress.text)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
