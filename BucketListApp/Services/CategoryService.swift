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
    static func showCategoryNames(_ firUser: FIRUser, completion: @escaping ([String]?) -> Void) { //prepares to send category names to firebase
        
        let catNameRef = Database.database().reference().child("catergoryName").child(firUser.uid) //making the nodes in firebase DISCLAIMER: only for the catergoryNAMES node in firebase
            print("userid in CatergoryWhatevr: \(firUser.uid)")
        catNameRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let names = snapshot.value as? [String]
            //print("snapshot is: \//(snapshot.value)")
            // print("names is \(names)")
            if let names = names {
                Category.arrayOfCategoryNames = names
               // print("Catgory.arrayOfCategoryNames is: \(Category.arrayOfCategoryNames)")
                completion(names)
            }else {
                let tempArray : [String] = []
                catNameRef.setValue(tempArray)
                completion(names)
            }
            // print("About to print names")
            // print(names)
            // makes it so that you can convert the DatabaseReference types
        })
        
        print("in showCategoryNames")
    }
    
    //2
    static func showCategory(_ firUser: FIRUser, catName: String, completion: @escaping ([String]?) -> Void) {
        
        let categoryRef = Database.database().reference().child("category").child(firUser.uid).child(catName)
        
        categoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let listItems = snapshot.value as? [String]
            if let listItems = listItems {
                completion(listItems)
                print("listItems 1 are: \(listItems)")
            } else { //if it's empty
                let tempArray : [String] = []
                categoryRef.setValue(tempArray)
                completion(listItems)
                print("in else")
                print("listItems 2 are: \(listItems)")
            }
        }) //this gives back an entire array
        print("in showCategory")
    }
    
    //3
    static func makeCategoryNames(_ firUser: FIRUser, catNameArray: [String]) { //send the names of the catergory to firebase DISCLAIMER: only for the catergoryNAMES node in firebase
        
        
        showCategoryNames(firUser){  names in
            //  print("In cat names")
            let subArray = catNameArray
            let catNameRef = Database.database().reference().child("catergoryName").child(firUser.uid)
            
            if let names = names {
                //sppend and then set value
                let newArray = subArray + names
                //print("Over here")
                catNameRef.setValue(newArray)
            }else{
                //setvalue
                // print ("In else statement")
                //print (names)
                catNameRef.setValue(catNameArray)
            }
        }
        print("in makeCategoryNames")
    }
    
    //4
    static func makeCategory(_ firUser: FIRUser, catName: String, listItemArray: [String]) {
        
        showCategory(firUser, catName: catName){  names in
            
            let categoryRef = Database.database().reference().child("category").child(firUser.uid).child(catName)
            categoryRef.setValue(listItemArray)
            print("listItemArray is: \(listItemArray)")
        }
        print("in makeCategory")
    }
}

//showCategory(firUser, catName: catName){  listItems in
//    let subArray = listItemArray
//    let categoryRef = Database.database().reference().child("category").child(firUser.uid).child(catName)
//
//    if let listItems = listItems {
//        let newArray = subArray + listItems
//        categoryRef.setValue(newArray)
//        print("listItemArray is: \(newArray)")
//    }
//}
//print("in makeCategory")
//}
//}



//modify database setValue




