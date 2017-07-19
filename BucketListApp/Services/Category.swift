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

class Category {
    // MARK: - Singleton
    // 1
    static var arrayOfCategoryNames: [String] = []
    
    
//    var key: String?
//    let user: User
//    var listItemArray: [String]
//    var categoryName: String
//    
//    var dictValue: [String] {
//        let userDict = ["uid" : user.uid,
//                        "username" : user.username]
//        return ["Category" : categoryName, "List Items": listItemArray, "User" : userDict]
//    }
//    
//    init(categoryName: String, listItems: [String]) {
//        self.categoryName = categoryName
//        self.listItemArray = listItems
//        self.user = User.current
//    }
//    
//    
//    
//    
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String : Any],
//            let userDict = dict["user"] as? [String : Any],
//            let uid = userDict["uid"] as? String,
//            let username = userDict["username"] as? String
//            else { return nil }
//        
//        self.key = snapshot.key
//        self.user = User(uid: uid, username: username)
//    }
}
