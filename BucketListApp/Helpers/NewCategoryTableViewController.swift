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
    
    var arrayOfListItems = ["Picnic", "Bike Ride"]
    
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

   
    


}
