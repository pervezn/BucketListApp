//
//  Places.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/13/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import SwiftyJSON

class Places {
    //Mark - Properties
    let formatted_Address: String
    let lat: Double
    let lng: Double
    let id: String?
    let name: String
    
    // MARK: - Init
    
    init(formatted_Address: String, lat: Double, lng: Double, id: String?, name: String) {
        self.id = id
        self.name = name
        self.formatted_Address = formatted_Address
        self.lat = lat
        self.lng = lng
    }
    
    init(json: JSON) {
            let name = json["name"].stringValue
            let formatted_Address = json["formatted_address"].stringValue
            let lat = json["geography"]["location"]["lat"].doubleValue
            let lng = json["geography"]["location"]["lat"].doubleValue
            let id = json["id"].stringValue
        //print("in initializer!!!!!!!!!!")
        self.id = id
        self.name = name
        self.formatted_Address = formatted_Address
        self.lat = lat
        self.lng = lng
    }
   //Uncoment this to make a list item: You get a thread bad access error though...
    convenience init(formatted_Address: String, lat: Double, lng: Double, name: String){
        self.init(formatted_Address: formatted_Address, lat: lat, lng: lng,id: nil, name: name)
    }
   
}


