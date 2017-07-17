//
//  NewCategoryTableViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/11/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class NewCategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newTableView: UITableView!
    
    var arrayOfListItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            } else if identifier == "save" {
                print("Save button tapped")
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
}

extension NewCategoryTableViewController: AddNewCellDelegate {
    func didPressAddButton(_ addListItemButton: UIButton, on cell: AddNewTableViewCell) {
       
        guard let indexPath = newTableView.indexPath(for: cell)
            else {
            //    print("in the else statement")
        
                return }
       // print("outside first else")
        //gets the indexPath for the new cell we're making (?)
        
       // let newCell = NewTableViewCell()
        
//        guard let cell = self.newTableView.cellForRow(at: indexPath) as? NewTableViewCell
//            else {
//                print("in the 2nd else statement")
//
//                return }
        
        arrayOfListItems.insert("added", at: indexPath.row)
        
        self.newTableView.reloadData()
        print("\(indexPath)")
//        DispatchQueue.main.async {
//            self.configureCell(cell, with: newCell)
//        }
        
    }
}
