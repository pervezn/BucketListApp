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
    
    //1
    static func showCategoryNames(_ firUser: FIRUser, completion: @escaping ([String]?) -> Void) {
    
    //var categoryName = [String]()
    
        let catNameRef = Database.database().reference().child("catergoryName").child(firUser.uid) //making the nodes in firebase
        
        let catNameRef2 = catNameRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let names = snapshot.value as? [String]
            completion(names) // makes it so that you can convert the DatabaseReference types
        })
        
        print("in showCategoryNames")
    }
    
    //2
    static func showCategory(_ firUser: FIRUser, catName: String, completion: @escaping ([String]?) -> Void) {
        
    
        let categoryRef = Database.database().reference().child("category").child(firUser.uid).child(catName)
        
        let categoryRef2 = categoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let listItems = snapshot.value as? [String]
            completion(listItems)
      }) //this gives back an entire array
        print("in showCategory")
    }
    
    //3
    static func makeCategoryNames(_ firUser: FIRUser, catNameArray: [String]) {
        
        showCategoryNames(firUser){  names in
        
        let subArray = catNameArray
        let catNameRef = Database.database().reference().child("catergoryName").child(firUser.uid)
            
            if let names = names {
                //sppend and then set value
                let newArray = subArray + names
                catNameRef.setValue(newArray)
            }else{
                //setvalue
                catNameRef.setValue(names)
            }
        }
        print("in makeCategoryNames")
    }
    
    //4
    static func makeCategory(_ firUser: FIRUser, catName: String, listItemArray: [String]) {
        let categoryRef = Database.database().reference().child("category").child(firUser.uid).child(catName)
        categoryRef.setValue(listItemArray)
            print("in makeCategory")
        
    }
}



//modify database setValue




