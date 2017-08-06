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

class NewCategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var categoryNameTextField: UITextField!

    @IBOutlet weak var newTableView: UITableView!
    
    @IBOutlet weak var saveProgressButton: UIButton!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    var locName : String?
    var locAddress : String?
    var locPlace : Places?
    var saveProgressStatus = false
    
    var ref: DatabaseReference?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryNameTextField.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        newTableView.delegate = self
        newTableView.dataSource = self
        
        //self.newTableView.layer.cornerRadius = 10
        //self.newTableView.layer.masksToBounds = true
        
        navigationItem.titleView?.tintColor = UIColor.myOrangeColor()
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleLabel.text = "Create a List"
        titleLabel.textColor = UIColor.myOrangeColor()
        titleLabel.layer.zPosition = 1000
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.navigationItem.titleView = titleLabel
       // self.navigationBar.tintColor = UIColor.myOrangeColor()
        
       // saveProgressButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "pressedSaveProgressButton"))
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

            return arrayOfListItems2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newTableViewCell", for: indexPath) as! NewTableViewCell
        
        print("arrayOfListItems2.count is: \(arrayOfListItems2.count)")
        
        print("indexPath.row is: \(indexPath.row)")
    
       // print("cell.locationAddressDisplay.text is: \(cell.locationAddressDisplay.text)")
        
        
       // print("arrayOfListItems2[indexPath.row].address is: \(arrayOfListItems2[indexPath.row].itemTitle)")
        
        cell.locationAddressDisplay.text = arrayOfListItems2[indexPath.row].address //locAddress
        cell.locationNameDisplay.text = arrayOfListItems2[indexPath.row].itemTitle  //locName
     
            return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hotAirBalloon.png")!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //, _ firUser: FIRUser
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                // print("Cancel button tapped")
                
                if self.saveProgressStatus == true {
                    
                    MainPageViewController.removeCategory(category: arrayOfCategories[arrayOfCategories.count - 1])
                    arrayOfCategories.remove(at: (arrayOfCategories.count - 1))
                    
                }
                
                
                //need to delete the list items still !!!!!!
                arrayOfListItems2 = []
            } else if identifier == "save" {
                //print("Save button tapped")
        
                arrayOfListItems2 = []
            } else if identifier == "toAddLocMapView2" {
                var vc = segue.destination as! AddLocationMapViewController
                vc.fromNewCategory = true
            }
        }
    }
    
    @IBAction func unwindToNewCategoryTableViewController(_ segue: UIStoryboardSegue) {
        
       locName = UserDefaults.standard.string(forKey: "locationName")
       locAddress = UserDefaults.standard.string(forKey: "locationAddress")
   //    print("UserDefault LocationName: \(UserDefaults.standard.string(forKey: "locationName"))")
    //    print("locName is: \(locName)")
 //       print("locAddress is: \(locAddress)")

        newTableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            // 3
            // print("the before indexPath is: \(indexPath.row)")
            arrayOfListItems2.remove(at: indexPath.row)
            print("in table View")
            // print("the after indexPath is: \(indexPath.row)")
            self.newTableView.reloadData()
        }
    }
    
    func createAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.newTableView.endEditing(true) //why doesn't this work?
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        categoryNameTextField.resignFirstResponder()
        return(true)
    }
    
    @IBAction func pressedAddButton(_ sender: Any) {
       // print("pressed add button")
        
       /* guard let indexPath = newTableView.indexPath(for: cell)
            else { return }
        
        arrayOfListItems.insert("added", at: indexPath.row)
        self.newTableView.reloadData()*/
        //arrayOfListItems.append("added")
        self.newTableView.reloadData()
    }
    
    @IBAction func pressedSaveProgressButton(_ sender: Any) {
        let current = Auth.auth().currentUser
        if categoryNameTextField.text == "" {
            createAlert(title: "WARNING", messege: "Must have a list title.")
        } else {
        CategoryService.makeCategory(current!, catTitle: categoryNameTextField.text!, completion: { (category) in
            arrayOfCategories.append(category!)
            print("listItemIDs for newly created Category is: \(category?.listItemIDs.count)")
        })
        
        self.saveProgressButton.isHidden = true
        self.instructionLabel.isHidden = false
        self.addButton.isHidden = false
        self.saveProgressStatus = true
        }
        categoryNameTextField.resignFirstResponder()
        categoryNameTextField.isUserInteractionEnabled = false
    }
}
extension NewCategoryTableViewController: AddNewCellDelegate {
    
    
    func didPressAddButton(_ addListItemButton: UIButton, on cell: AddNewTableViewCell) {
        
        guard let indexPath = newTableView.indexPath(for: cell)
            else { return }
      
        let current = Auth.auth().currentUser
   
    }
}
