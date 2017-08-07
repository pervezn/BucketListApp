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
    
    static func showListItems(_ firUser: FIRUser, catID: String, /*listItemID: String,*/ completion: @escaping ([ListItem]?) -> Void) {
        
        let listItemRef = Database.database().reference().child("listItem").child(firUser.uid).child(catID)
        
        listItemRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            var emptyArray = [ListItem]()
            for eachListItem in snapshot {
                if let items = ListItem(snapshot: eachListItem) {
                emptyArray.append(items)
                }
            }
            completion(emptyArray)
        })
    }

    static func makeListItems(_ firUser: FIRUser, catID: String, lat: Double, lng: Double, isChecked: Bool, itemTitle: String, address: String, completion: @escaping (ListItem?) -> Void) {
        
        let listItemRef = Database.database().reference().child("listItem").child(firUser.uid).child(catID).childByAutoId()//one item
        
        var dict : [String : Any] = Dictionary()
        dict["title"] = itemTitle
        dict["address"] = address
        dict["latitude"] = lat
        dict["longitude"] = lng
        dict["complete?"] = isChecked
        
        listItemRef.setValue(dict)
     updateCategoryItems(listItemID: listItemRef.key, catID: catID)
    
    let listIt = ListItem(itemTitle: itemTitle, address: address, key: listItemRef.key, lat: lat, lng: lng, isChecked: false)
        
        completion(listIt)
    }
    
    static func updateCategoryItems(/*category: Category,*/ listItemID: String, catID: String) {
            let categoryRef = Database.database().reference().child("category").child(User.current.uid).child(catID)
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





















