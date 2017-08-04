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

var arrayOfPlaces = [Places]()


class AddLocationMapViewController: UIViewController, UITextFieldDelegate
    
{
    
    
    let googleSearchPlacesAPIKey = "AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M"
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationAddress: UILabel!
    @IBOutlet weak var doneButton2: UIButton!
    
    // var marker = GMSMarker() // Reason 1
    
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var addressText: String = "address"
    var long : Double = 0.0
    var lat : Double = 0.0
    var fromNewCategory : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.layer.cornerRadius = 3
        doneButton.clipsToBounds = true
        
        doneButton2.layer.cornerRadius = 3
        doneButton2.clipsToBounds = true
        
        self.locationName.delegate = self
        
        let controller = GooglePlacesSearchController(apiKey: googleSearchPlacesAPIKey, placeType: PlaceType.all)
        
        //definesPresentationContext = true
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.myOrangeColor()
        
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        // definesPresentationContext = true
        
        // Keep the navigation bar visible.
        
        controller.didSelectGooglePlace { (place) -> Void in //allows you to select a location in the search bar.
            
            self.locationAddress.text = place.formattedAddress
            self.locationAddress.sizeToFit()
            self.lat = place.coordinate.latitude
            self.long = place.coordinate.longitude
            print("Place latitude coordinate: \(place.coordinate.latitude)")
            print("Place longitude coordinate: \(place.coordinate.longitude)")
            
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.lat, self.long)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            self.locationMapView.addAnnotation(annotation)
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotAirBalloon.png")!)
        
        if fromNewCategory == true {
            doneButton.isHidden = false
            doneButton2.isHidden = true
        } else {
            doneButton2.isHidden = false
            doneButton.isHidden = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationName.resignFirstResponder()
        return(true)
    }
    
    func createAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("in prepare segue")
        let current = Auth.auth().currentUser
        if segue.identifier == "unwindToNewCategoryTableViewController" {
            if locationName.text == "" {
                createAlert(title: "WARNING", messege: "Must have a name.")
            } else {
                
                UserDefaults.standard.set(locationName.text, forKey: "locationName")
                //arrayOfListItems2.removeAll()
                
                ListItemService.makeListItems(current!, catID: arrayOfCategories[arrayOfCategories.count-1].key, lat: lat, lng: long, isChecked: false, itemTitle: locationName.text!, address: locationAddress.text!, completion:  { (listItem) in
                    arrayOfListItems2.append(listItem!)
                    print(listItem?.itemTitle)
                    print(arrayOfListItems2.count)
                    print("item appeneded")
                    //print("listItemIDs.count is: \(arrayOfCategories[0].listItemIDs)")
                })
            }
        } else if segue.identifier == "unwindToViewCategoryTableViewController" {
            let viewCategory: ViewCategoryTableViewController = segue.destination as! ViewCategoryTableViewController
            self.doneButton.isHidden = true
            self.doneButton2.isHidden = false
            
             var currentCategory = Category(categoryTitle: "", listItemsArray: [], listItemIDs: [""], key: "")
            
            for i in 0...arrayOfCategories.count - 1 {
                if viewCategory.title == arrayOfCategories[i].categoryTitle
                {
                    currentCategory = arrayOfCategories[i]
                }
            }
            
            ListItemService.makeListItems(current!, catID: currentCategory.key, lat: lat, lng: long, isChecked: false, itemTitle: locationName.text!, address: locationAddress.text!, completion:  { (listItem) in
                arrayOfListItems2.append(listItem!)
                print(listItem?.itemTitle)
                print(arrayOfListItems2.count)
            })
           
            
            
            ListItemService.showListItems(current!, catID: currentCategory.key) { (listItem) in
                if let liIt = listItem {
                    arrayOfListItems2 = liIt
                    viewCategory.viewTableView.reloadData()
                    viewCategory.currentCategory = currentCategory
                }
            }
        }
    }
}

extension AddLocationMapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        //  print("In the delegate")
        // Do something with the selected place.
        // print("Place bla name: \(place.name)")
        // print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
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
