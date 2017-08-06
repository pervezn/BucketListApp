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
    @IBOutlet weak var addListItemButton: UIBarButtonItem!
    
    
    var editingItems: Bool = false
    
    
    //    @IBOutlet var viewTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //removes tableView Lines
        self.viewTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true

        navigationItem.backBarButtonItem?.tintColor = UIColor.myOrangeColor()
        self.editButtonItem.tintColor = UIColor.myOrangeColor()
        self.navigationItem.rightBarButtonItems = [self.editButtonItem, self.addListItemButton] //don't touch
        viewTableView.delegate = self
        viewTableView.dataSource = self
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        titleLabel.text = self.title
        titleLabel.textColor = UIColor.myOrangeColor()
        titleLabel.layer.zPosition = 1000
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.navigationItem.titleView = titleLabel


        
        self.navigationController?.navigationBar.tintColor = UIColor.myOrangeColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotAirBalloon.png")!)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "hotAirBalloon.png")
        
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.tableView.backgroundView = imageView
        
        if isEditing == true {
            self.addListItemButton.isEnabled = true
            self.addListItemButton.tintColor = UIColor.myOrangeColor()
            //this is your problem
        } else {
            self.addListItemButton.isEnabled = false
            self.addListItemButton.tintColor = UIColor.clear
        }
    
        
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
        //gets a listItemID
        
        let listItemRef2 = Database.database().reference().child("category").child((current?.uid)!).child(category.key).child("itemsArray")
        //gets all of the list item IDs for a Category
        
        //print("currentCategory.listItemsIDs.count is: \(currentCategory?.listItemIDs.count)")
        if currentCategory?.listItemIDs.count == 1 {
            currentCategory?.listItemIDs.remove(at: 0)
        } else {
            for i in 0..<(currentCategory?.listItemIDs.count)! {
                if currentCategory?.listItemIDs[i] == listItem.key {
                    currentCategory?.listItemIDs.remove(at: i)
                    break
                }
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
        
        cell.completeButton.isSelected = arrayOfListItems2[indexPath.row].isChecked
        
        if cell.completeButton.isSelected == true { //dark color
            cell.itemAddress.textColor = UIColor.gray
            cell.itemLabel.textColor = UIColor.gray
        } else {
            cell.itemAddress.textColor = UIColor.myTanColor()
            cell.itemLabel.textColor = UIColor.myTanColor()
        }
        
        
        return cell
        
    }

    
    override func setEditing (_ editing:Bool, animated:Bool) {
        super.setEditing(editing,animated:animated)
        if isEditing == false {
            addListItemButton.isEnabled = editing
            self.addListItemButton.tintColor = UIColor.clear
        } else {
            print("editingItems in the else is:\(editingItems)")
            
            self.addListItemButton.isEnabled = !editingItems
            self.addListItemButton.tintColor = UIColor.myOrangeColor()
        }
    }
    
    @IBAction func addListItemButtonTapped(_ sender: Any) {
    }
    
    @IBAction func unwindToViewCategoryTableViewController(_ segue: UIStoryboardSegue) {
        
        print("here!!!")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddLocMapView" {
            var vc = segue.destination as! AddLocationMapViewController
            vc.fromNewCategory = false
        }
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
        
        
        arrayOfListItems2[indexPath.row].isChecked = !arrayOfListItems2[indexPath.row].isChecked
        
            let listItemRef = Database.database().reference().child("listItem").child((current?.uid)!).child(currentCategory.key).child(arrayOfListItems2[indexPath.row].key).child("complete?")
            
            listItemRef.setValue(arrayOfListItems2[indexPath.row].isChecked)

        tableView.reloadData()
        
    }
}
