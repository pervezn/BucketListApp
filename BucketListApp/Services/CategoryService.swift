//
//  CategoryService.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/18/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CategoryService {
    
    static func showCategory(_ firUser: FIRUser, completion: @escaping ([Category]?) -> Void) {
        
        let categoryRef = Database.database().reference().child("category").child(firUser.uid)
        
        categoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            var emptyArray = [Category]()
            var emptyArrayOfListIDs = [String]()
            for eachCat in snapshot {
                if let category = Category(snapshot: eachCat) {
                    emptyArray.append(category)
                }
            }
            completion(emptyArray)
        })
    }
    
    static func makeCategory(_ firUser: FIRUser, catTitle: String, completion: @escaping (Category?) -> Void) {
        
        let categoryRef = Database.database().reference().child("category").child(firUser.uid).childByAutoId() //this gets the Category ID
        
        var dict : [String : Any] = Dictionary()
        dict["title"] = catTitle
        
        let itemIdArray = [String]() //this might be an issue
        dict["itemsArray"] = itemIdArray
        
        categoryRef.setValue(dict)// created it in Catergory still need to add to User
            
        updateUserCategories(firUser, catID: categoryRef.key) //added User
       
        let cat = Category(categoryTitle: catTitle, listItemsArray: arrayOfListItems2, listItemIDs: itemIdArray, key: categoryRef.key)
        
        completion(cat)
        
    }
    
    static func updateUserCategories(_ firUser: FIRUser,  catID: String) {
        let userRef = Database.database().reference().child("users").child(firUser.uid)//user referenece
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String : Any],
            let categories = dict["categories"] as? [String],
            let username = dict["username"] as? String {
                
                var newArray = [String]()
                newArray.append(contentsOf: categories)
                newArray.append(catID)
                
                var dict2 : [String : Any] = Dictionary()
                dict2["username"] = username
                dict2["categories"] = newArray
                
                userRef.setValue(dict2)
            } else {
                let dict = snapshot.value as? [String : Any]
                let username = dict?["username"] as? String
                var newArray : [String] = [catID]
                var dict2 : [String : Any] = Dictionary()
                dict2["username"] = username
                dict2["categories"] = newArray
                
                
                userRef.setValue(dict2)
            }
        })
    }
}
