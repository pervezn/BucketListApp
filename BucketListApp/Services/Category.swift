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
   
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String
                        else { return nil }
        
        if let itemIDs = dict["itemsArray"] as? [String] {
            self.key = snapshot.key
            self.categoryTitle = title
            self.listItemIDs = itemIDs
        }else {
            self.key = snapshot.key
            self.categoryTitle = title
            self.listItemIDs = [String]()
        }
    }

}
