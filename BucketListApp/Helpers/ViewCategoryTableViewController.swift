//
//  ViewCategoryTableViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import Firebase

class ViewCategoryTableViewController: UITableViewController  {

    var currentCategory : Category?
    
    @IBOutlet var viewTableView: UITableView!
    
//    @IBOutlet var viewTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    //removes tableView Lines
    self.viewTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        viewTableView.delegate = self
        viewTableView.dataSource = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            
            removeListItem(category: currentCategory!, listItem: arrayOfListItems2[indexPath.row])
            
            arrayOfListItems2.remove(at: indexPath.row)
            self.viewTableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       // print("Array count: \(arrayOfListItems2.count)")
       
        return arrayOfListItems2.count
    }
    
    func removeListItem(category: Category, listItem: ListItem) {
        
        let current = Auth.auth().currentUser
        
         let listItemRef = Database.database().reference().child("listItem").child((current?.uid)!).child(category.key).child(listItem.key)
        
        let listItemRef2 = Database.database().reference().child("category").child((current?.uid)!).child(category.key).child("itemsArray")
        
        for i in 0...(currentCategory?.listItemIDs.count)! - 1 {
            if currentCategory?.listItemIDs[i] == listItem.key {
                currentCategory?.listItemIDs.remove(at: i)
                break
            }
        }
        
        listItemRef.removeValue()
        listItemRef2.setValue(currentCategory?.listItemIDs)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCategoryTableViewCell", for: indexPath) as! ViewCategoryTableViewCell
        
        cell.itemLabel.text = arrayOfListItems2[indexPath.row].itemTitle
        cell.itemAddress.text = arrayOfListItems2[indexPath.row].address
        cell.delegate = self

       return cell
   
    }
}

extension ViewCategoryTableViewController: ViewCategoryCellDelegate {
    func didTapCompleteButton(_ completeButton: UIButton, on
        cell: ViewCategoryTableViewCell) {
        let current = Auth.auth().currentUser
        
        var currentCategory = Category(categoryTitle: "", listItemsArray: [], listItemIDs: [""], key: "")
        
        for i in 0...arrayOfCategories.count - 1 {
            if self.title == arrayOfCategories[i].categoryTitle
            {
                currentCategory = arrayOfCategories[i]
            }
        }
    
        guard let indexPath = viewTableView.indexPath(for: cell)
            else { return }
        
        if completeButton.currentImage == UIImage(named: "iconmonstr-circle-6-32.png") {
            completeButton.setImage(UIImage(named: "iconmonstr-circle-1-32.png"), for: .normal)
            //then isChecked = true
            //setValue
            let listItemRef = Database.database().reference().child("listItem").child((current?.uid)!).child(currentCategory.key).child(arrayOfListItems2[indexPath.row].key).child("complete?")
            //arrayOfListItems2[indexPath.row].isChecked = true
            listItemRef.setValue(true)
            
            cell.itemAddress.textColor = UIColor.gray
            cell.itemLabel.textColor = UIColor.gray
            
        } else {
            completeButton.setImage(UIImage(named: "iconmonstr-circle-6-32.png"), for: .normal)
            //then isChecked = false
            //setValue
            let listItemRef = Database.database().reference().child("listItem").child((current?.uid)!).child(currentCategory.key).child(arrayOfListItems2[indexPath.row].key).child("complete?")
             //arrayOfListItems2[indexPath.row].isChecked = false
            listItemRef.setValue(false)
            cell.itemAddress.textColor = UIColor.black
            cell.itemLabel.textColor = UIColor.black
        }

    }
}
