//
//  ListItem.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/20/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class ListItem {
    var itemTitle : String
    var address : String
    var key : String
    var lat : Double
    var lng : Double
    var isChecked : Bool
    
    
    init(itemTitle: String, address: String, key: String, lat: Double, lng: Double, isChecked: Bool)
    {
        self.itemTitle = itemTitle
        self.address = address
        self.key = key
        self.lat = lat
        self.lng = lng
        self.isChecked = isChecked
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String,
            let address = dict["address"] as? String,
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double,
            let isChecked = dict["complete?"] as? Bool
            else { return nil }
        
        self.key = snapshot.key
        self.lat = latitude
        self.lng = longitude
        self.itemTitle = title
        self.address = address
        self.isChecked = isChecked
    }
    
    //create an initializer that takes a place
    init(place: Places, key: String)
    {
        itemTitle = place.name
        address = place.formatted_Address
        self.isChecked = false
        self.key = key
        self.lat = place.lat
        self.lng = place.lng
    }
}
