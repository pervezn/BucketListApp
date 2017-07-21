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
           // print("userid in CatergoryWhatevr: \(firUser.uid)")
        catNameRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let names = snapshot.value as? [String]
            //print("snapshot is: \//(snapshot.value)")
            // print("names is \(names)")
            if let names = names {
                arrayOfCategoryNames = names
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
    static func showCategory(_ firUser: FIRUser, catID: String, completion: @escaping (Category?) -> Void) {
        
        //print("cat name is \(catName)")
        let categoryRef = Database.database().reference().child("category").child(catID)
        categoryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let category = Category(snapshot: snapshot)
                completion(category)
        }) 
        print("in showCategory")
    }
    
    static func makeCategory(_ firUser: FIRUser, catTitle: String) {
        
        let categoryRef = Database.database().reference().child("category").childByAutoId() //this gets the Category ID
        
        var dict : [String : Any] = Dictionary()
        dict["title"] = catTitle
        //dict["itemsArray"] = listItemArray
        let itemIdArray = [String]()
        dict["itemsArray"] = itemIdArray
        
        categoryRef.setValue(dict)// created it in Catergory still need to add to User
        updateUserCategories(firUser, catID: categoryRef.key)
        print("in makeCategory")
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
                dict2["catergories"] = newArray
                
                userRef.setValue(dict2)
            } else {
                let dict = snapshot.value as? [String : Any]
                let username = dict?["username"] as? String
                var newArray : [String] = [catID]
                var dict2 : [String : Any] = Dictionary()
                dict2["username"] = username
                dict2["catergories"] = newArray
                
                userRef.setValue(dict2)
            }
        }) //added to User
     
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
}
    //4


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




