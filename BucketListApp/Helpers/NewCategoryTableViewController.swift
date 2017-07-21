//
//  NewCategoryTableViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/11/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseAuthUI
import Firebase
//typealias FIRUser = FirebaseAuth.User

var arrayOfListItems: [String] = []

var arrayOfListItems2: [ListItem] = []

var listItemIDsArray: [String] = []

class NewCategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var categoryNameTextField: UITextField!

    @IBOutlet weak var newTableView: UITableView!
    
    
    var ref: DatabaseReference?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        newTableView.delegate = self
        newTableView.dataSource = self
    
        //self.newTableView.register(UITableViewCell.self, forCellReuseIdentifier: "newTableViewCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 1
        } else {
            return arrayOfListItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        //var cell = UITableViewCell()
        
        //if indexPath.row != arrayOfListItems.count - 1
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newTableViewCell", for: indexPath) as! NewTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewTableViewCell", for: indexPath) as! AddNewTableViewCell
            cell.delegate = self
            return cell
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //, _ firUser: FIRUser
        if let identifier = segue.identifier {  //FIXME: nothing prints
            if identifier == "cancel" {
               // print("Cancel button tapped")
            } else if identifier == "save" {
               // print("Save button tapped")
                let current = Auth.auth().currentUser
                
                
                CategoryService.makeCategory(current!, catTitle: categoryNameTextField.text!)
                
            }
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            // 3
            // print("the before indexPath is: \(indexPath.row)")
            arrayOfListItems.remove(at: indexPath.row)
            // print("the after indexPath is: \(indexPath.row)")
            self.newTableView.reloadData()
        }
    }
    
    @IBAction func pressedAddButton(_ sender: Any) {
        print("pressed add button")
    }
    
}
extension NewCategoryTableViewController: AddNewCellDelegate {
    
    
    func didPressAddButton(_ addListItemButton: UIButton, on cell: AddNewTableViewCell) {
        
        guard let indexPath = newTableView.indexPath(for: cell)
            else { return }
      
        
       arrayOfListItems.insert("added", at: indexPath.row)
        self.newTableView.reloadData()
//
        let current = Auth.auth().currentUser
        
       //        
//        let category = Category(snapshot: 
//        
//        
//        for i in category.listItemsIDs {
//            ListItemService.makeListItems(current!, category.listItemIDs[i], listItemArray: arrayOfListItems2)
//        }
//        print("arrayOfListItem2 is: \(arrayOfListItems2)")
        
    }
}
