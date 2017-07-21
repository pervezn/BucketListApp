//
//  ViewCategoryTableViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class ViewCategoryTableViewController: UITableViewController{

    
    @IBOutlet var viewTableView: UITableView!
    
//    @IBOutlet var viewTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //print("in ViewDidLoad")
    
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
       
        return arrayOfListItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCategoryTableViewCell", for: indexPath)
        

       
    let randomName = ViewCategoryTableViewCell()
       
        randomName.itemLabel?.text = "Table Label"
        return cell
    }
}
