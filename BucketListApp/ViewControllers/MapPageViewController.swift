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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(image: UIImage(named: "iconmonstr-menu-2-32"), style: .plain, target: self, action: "showDropdown")
        button.tintColor = UIColor.myOrangeColor()
        
        
        navigationItem.rightBarButtonItem = button
        
        mapView.isZoomEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.showsBuildings = true
        
        
        
        Alamofire.request(url).validate().responseJSON() { response in
            
            let info = JSON(response.result.value)
            
            let placesArray = info["results"].arrayValue
            
            for place in placesArray {
                let newPlace = Places(json: place)
            }
        }
        
        let current = Auth.auth().currentUser
        if arrayOfCategories.count != 0 {
            ListItemService.showListItems(current!, catID: arrayOfCategories[0].key) { (listItem) in
                if let liIt = listItem {
                    if liIt.count > 0 {
                        self.pinArray = liIt
                        for i in 0...self.pinArray.count - 1 {
                            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.pinArray[i].lat , self.pinArray[i].lng)
                            let annotation = MKPointAnnotation()
                            annotation.title = self.pinArray[i].itemTitle
                            annotation.coordinate = location
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            }
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
        for annotation in self.mapView.annotations {
            self.mapView.removeAnnotation(annotation)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menu = buildDummyDefaultMenu()
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
}

extension MapPageViewController {
    
    /**
     Create dummy menu with default settings
     
     - returns: The dummy menu
     */
    fileprivate func buildDummyDefaultMenu() -> AZDropdownMenu {
        var titleArray = [String]()
        if arrayOfCategories.count != 0 {
            for i in 0...arrayOfCategories.count - 1 {
                titleArray.append(arrayOfCategories[i].categoryTitle)
            }
        }
        let menu = AZDropdownMenu(titles: titleArray)
        menu.itemFontSize = 16.0
        menu.itemFontName = "Helvetica"
        menu.translatesAutoresizingMaskIntoConstraints = true
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            var pinArray = [ListItem]()
            var pinArray2 = [MKAnnotation]()
            let current = Auth.auth().currentUser
            ListItemService.showListItems(current!, catID: arrayOfCategories[indexPath.row].key) { (listItem) in
                
                
                self?.removeAllAnnotations()
                
                if let liIt = listItem {
                    for item in liIt {
                        pinArray.append(item)
                        
                    }
                    if pinArray.count == 0 {
                        self?.removeAllAnnotations()
                    } else {
                        for i in 0...(pinArray.count) - 1 {
                            
                            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(pinArray[i].lat, pinArray[i].lng)
                            let annotation = MKPointAnnotation()
                            annotation.title = pinArray[i].itemTitle
                            annotation.coordinate = location
                            self?.mapView.addAnnotation(annotation)
                            pinArray2.append(annotation)
                            
                        }
                        
                        self?.mapView.showAnnotations(pinArray2, animated: true)
                    }
                    self?.reloadInputViews()
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

