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
    
    
    init(itemTitle: String, address: String, key: String, lat: Double, lng: Double)
    {
        self.itemTitle = itemTitle
        self.address = address
        self.key = key
        self.lat = lat
        self.lng = lng
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String,
            let address = dict["address"] as? String,
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double
            else { return nil }
        
        self.key = snapshot.key
        self.lat = latitude
        self.lng = longitude
        self.itemTitle = title
        self.address = address
    }
    
    //create an initializer that takes a place
    init(place: Places, key: String)
    {
        itemTitle = place.name
        address = place.formatted_Address
        self.key = key
        self.lat = place.lat
        self.lng = place.lng
    }
}
