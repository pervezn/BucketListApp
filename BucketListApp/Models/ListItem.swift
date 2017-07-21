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
    
    
    init(itemTitle: String, address: String, key: String)
    {
        self.itemTitle = itemTitle
        self.address = address
        self.key = key
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String,
            let address = dict["address"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.itemTitle = title
        self.address = address
    }
}
