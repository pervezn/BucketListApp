//
//  Category.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/18/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

var arrayOfCategoryNames: [String] = [] //[Category] = []

class Category {
    // MARK: - Singleton
    // 1
    
    //static var arrayOfCategoryNames: [String] = []
    
    let categoryTitle: String
    var listItemsArray: [ListItem]?
    var listItemIDs: [String]
    var key: String
    


    
    init(categoryTitle: String, listItemsArray: [ListItem], listItemIDs: [String], key: String) {
        self.categoryTitle = categoryTitle
        self.listItemsArray = listItemsArray
        self.listItemIDs = listItemIDs
        self.key = key
    }
//
//    
//    
//    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String,
            let itemIDs = dict["listItemIDs"] as? [String]
            else { return nil }
        
        self.key = snapshot.key
        self.categoryTitle = title
        self.listItemIDs = itemIDs
        
        
    }
}
