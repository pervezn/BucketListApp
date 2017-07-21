//
//  ListItemService.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/20/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ListItemService {
    
    static func showListItems(_ firUser: FIRUser, catID: String, listItemID: String, completion: @escaping (ListItem) -> Void) {
        
        let listItemRef = Database.database().reference().child("listItem").child(firUser.uid).child(catID)
        
        listItemRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let items = ListItem(snapshot: snapshot)
                completion(items!)
        })
    }

    static func makeListItems(_ firUser: FIRUser, catID: String, itemTitle: String, address: String) {
        
        let listItemRef = Database.database().reference().child("listItem").child(firUser.uid).child(catID).childByAutoId()//one item
        
        var dict : [String : Any] = Dictionary()
        dict["title"] = itemTitle
        dict["address"] = address
        
        listItemRef.setValue(dict)
    }
    
    static func updateCategoryItems(category: Category, listItemID: String) {
            let categoryRef = Database.database().reference().child("category").child(category.key)
            categoryRef.observeSingleEvent(of: .value, with: { (snapshot)in
                if let dict = snapshot.value as? [String : Any],
                let catTitle = dict["title"] as? String,
                    let listItemArray = dict["itemsArray"] as? [String] {
                    
                    var newArray = [String]()
                    newArray.append(contentsOf: listItemArray)
                    newArray.append(listItemID)
                    
                    var dict2 : [String : Any] = Dictionary()
                    dict2["title"] = catTitle
                    dict2["itemsArray"] = newArray
                    
                    categoryRef.setValue(dict2)
                    
                } else {
                    let dict = snapshot.value as? [String : Any]
                    let catTitle = dict?["title"] as? String
                    var newArray : [String] = [listItemID]
                    var dict2 : [String : Any] = Dictionary()
                    dict2["title"] = catTitle
                    dict2["itemsArray"] = newArray
                    
                    categoryRef.setValue(dict2)
                }
             
                
               
            })
        
    }
}





















