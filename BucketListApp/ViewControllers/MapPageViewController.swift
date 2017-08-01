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
import FirebaseAuthUI
import FirebaseAuth
import FirebaseDatabase
import Firebase
import AZDropdownMenu


class MapPageViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var menu : AZDropdownMenu?
    
     var placesClient: GMSPlacesClient!
    let url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=landmarks+in+chicago&key=AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M"
    var pinArray = [ListItem]()
   // var titleArray = [""]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
//        for i in 0...arrayOfCategories.count - 1 {
//            titleArray.append(arrayOfCategories[i].categoryTitle)
//        }
        
         //menu = AZDropdownMenu(titles: titleArray)

       // menu = AZDropdownMenu(titles: titleArray)
        let button = UIBarButtonItem(image: UIImage(named: "iconmonstr-menu-2-32"), style: .plain, target: self, action: "showDropdown")
        
        navigationItem.rightBarButtonItem = button
        
        menu = buildDummyDefaultMenu()
        
       
       // print("\n\nFrame", menu?.frame ?? "no value")
        //print("\n\nFrame", view.frame ?? "no value")


        
        
        
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
//        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.888543, -87.635444)
//       // let initialLocation = CLLocation(latitude: 41.888543, longitude: -87.635444) //change this to the person's initial location
//        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        mapView.setRegion(region, animated: true)
//        
//        let annotation = MKPointAnnotation()
//        
//        annotation.coordinate = location
//        annotation.title = "Hello there!"
//        mapView.addAnnotation(annotation)
        
        
        
        
        Alamofire.request(url).validate().responseJSON() { response in
            
            //print(response.result.value)
            let info = JSON(response.result.value)
            
            let placesArray = info["results"].arrayValue
            
            for place in placesArray {
                let newPlace = Places(json: place)
            }
            //print(placesArray)
        }
        
       
        
       // centerMapOnLocation(location: location) //right when you open the map it will go to this initial location
    
        
        
        let current = Auth.auth().currentUser
        
      //  for i in 0...arrayOfCategories.count - 1 {
            
            ListItemService.showListItems(current!, catID: arrayOfCategories[0].key) { (listItem) in
                if let liIt = listItem {
                    self.pinArray = liIt
                    //print("pinArray in completion is: \(self.pinArray.count)")
                    for i in 0...self.pinArray.count - 1 {
                        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.pinArray[i].lat , self.pinArray[i].lng)
                        let annotation = MKPointAnnotation()
                        annotation.title = self.pinArray[i].itemTitle
                        annotation.coordinate = location
                        self.mapView.addAnnotation(annotation)
                    }
                }
            //}
        }
        
    }
    
    func showDropdown() {
        if self.menu?.isDescendant(of: self.view) == true {
            self.menu?.hideMenu()
        } else {
            self.menu?.showMenuFromView(self.view)
        }
    }

    func removeAllAnnotations() {
        print("in remove")
        for annotation in self.mapView.annotations {
            self.mapView.removeAnnotation(annotation)
            print("in for loop")
        }
        print("mapView annotations are: \(self.mapView.annotations)")
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

extension MapPageViewController {
    
    /**
     Create dummy menu with default settings
     
     - returns: The dummy menu
     */
    fileprivate func buildDummyDefaultMenu() -> AZDropdownMenu {
        var titleArray = [""]
        
        for i in 0...arrayOfCategories.count - 1 {
            titleArray.append(arrayOfCategories[i].categoryTitle)
        }
        
        let menu = AZDropdownMenu(titles: titleArray)
        menu.itemFontSize = 16.0
        menu.itemFontName = "Helvetica"
        menu.translatesAutoresizingMaskIntoConstraints = true
//        menu.frame.offsetBy(dx: 0, dy: 100)
//        menu.autoresizingMask
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            //self?.pushNewViewController(titleArray[indexPath.row])
            var pinArray = [ListItem]()
             let current = Auth.auth().currentUser
           // print("indePath.row is: \(indexPath.row)")
            ListItemService.showListItems(current!, catID: arrayOfCategories[indexPath.row - 1].key) { (listItem) in
               
                self?.removeAllAnnotations()
               
                if let liIt = listItem {
                    self?.pinArray = liIt
                  //  print("pinArray in completion is: \(self?.pinArray.count)")
                    for i in 0...(self?.pinArray.count)! - 1 {
                        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self!.pinArray[i].lat , self!.pinArray[i].lng)
                        let annotation = MKPointAnnotation()
                        annotation.title = self?.pinArray[i].itemTitle
                        annotation.coordinate = location
                        self?.mapView.addAnnotation(annotation)
                    }
                    self?.reloadInputViews()
                    print("arrayOfCategories.count is: \(arrayOfCategories.count)")
                }
            }
        }
        
        return menu
    }
    
    /**
     Create dummy menu with some custom configuration
     
     - returns: The dummy menu
     */
    fileprivate func buildDummyCustomMenu() -> AZDropdownMenu {
        let dataSource = createDummyDatasource()
        let menu = AZDropdownMenu(dataSource: dataSource )
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            self?.pushNewViewController(dataSource[indexPath.row])
        }
        menu.itemHeight = 70
        menu.itemFontSize = 14.0
        menu.itemFontName = "Menlo-Bold"
        menu.itemColor = UIColor.white
        menu.itemFontColor = UIColor(red: 55/255, green: 11/255, blue: 17/255, alpha: 1.0)
        menu.overlayColor = UIColor.black
        menu.overlayAlpha = 0.3
        menu.itemAlignment = .center
        menu.itemImagePosition = .postfix
        menu.menuSeparatorStyle = .none
        menu.shouldDismissMenuOnDrag = true
        return menu
    }
    
    fileprivate func pushNewViewController(_ title: String) {
        let newController = UIViewController()
        newController.title = title
        newController.view.backgroundColor = UIColor.white
        DispatchQueue.main.async(execute: {
            self.show(newController, sender: self)
        })
    }
    
    fileprivate func pushNewViewController(_ item: AZDropdownMenuItemData) {
        self.pushNewViewController(item.title)
    }
    
    fileprivate func createDummyDatasource() -> [AZDropdownMenuItemData] {
        var dataSource: [AZDropdownMenuItemData] = []
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 1", icon:UIImage(imageLiteralResourceName: "iconmonstr-menu-2-32")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 2", icon:UIImage(imageLiteralResourceName: "iconmonstr-menu-2-32")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 3", icon:UIImage(imageLiteralResourceName: "iconmonstr-menu-2-32")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 4", icon:UIImage(imageLiteralResourceName: "iconmonstr-menu-2-32")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 5", icon:UIImage(imageLiteralResourceName: "iconmonstr-menu-2-32")))
        return dataSource
    }
    
    func dismissFromController() {
        self.dismiss(animated: true, completion: nil)
    }
}

