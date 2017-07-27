//
//  MainPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

var arrayOfCategories: [Category] = []

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var numberOfCollection1 = arrayOfCategories.count + 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        collectionView.dataSource = self
        
        let current = Auth.auth().currentUser
        
        CategoryService.showCategory(current!) { (category) in
            if let cat = category {
                arrayOfCategories = cat
                self.collectionView.reloadData()
            }
        }
        
        
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return arrayOfCategories.count
        } else {
            return 1
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as!CollectionViewCell
            cell.delegate = self
            cell.deleteButtonBackgroundView.layer.cornerRadius = cell.deleteButtonBackgroundView.bounds.width / 2.0
            cell.deleteButtonBackgroundView.layer.masksToBounds = true
            cell.deleteButtonBackgroundView.isHidden = !isEditing
            cell.titleButton.setTitle(arrayOfCategories[indexPath.row].categoryTitle, for: [])
            
            
            //print("titleButton.titleLabel.text is: \(cell.titleButton.titleLabel?.text)")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCollectionViewCell", for: indexPath) as! AddCollectionViewCell
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //transitions from the viewCategory and newCetegory view controllers bakc ot the main page view controller. Also transitions back to the main Page view controller after you press cancel or save, but that's not being registered.
        // print("in prepare")
        // 1
        if let identifier = segue.identifier {
            if identifier == "viewCategory" {
                // print("Transitioning to the view Catergory View Controller")
                let viewCategory: ViewCategoryTableViewController = segue.destination as! ViewCategoryTableViewController
            
               
                
                let current = Auth.auth().currentUser
                let cell = sender as? UIButton
                var currentCategory = Category(categoryTitle: "", listItemsArray: [], listItemIDs: [""], key: "")
                
                // print("the cell's title is: \(cell?.titleButton.currentTitle)")
                
                for i in 0...arrayOfCategories.count - 1 {
                    if cell?.currentTitle == arrayOfCategories[i].categoryTitle
                    {
                        currentCategory = arrayOfCategories[i]
                    }
                }
                
                
                ListItemService.showListItems(current!, catID: currentCategory.key) { (listItem) in
                    if let liIt = listItem {
                        arrayOfListItems2 = liIt
                        viewCategory.viewTableView.reloadData()
                        viewCategory.currentCategory = currentCategory
                    }
                }
                //Work for Thursday!!!
            } else if identifier == "newCategory" {
                // print("Transitioning to the new Catergory View Controller")
            }
            else if identifier == "cancel" { //cancel and save do not print
                //print("Cancel button tapped")
            } else if identifier == "save" {
                //print("Save button tapped")
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        //addButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    @IBAction func unwindToMainPageViewController(_ segue: UIStoryboardSegue) {
        // print("in unwindToMainPageViewController")
        collectionView.reloadData()
        
    }
    
    func removeCategory(category: Category) {
        let current = Auth.auth().currentUser
        
        let catRef = Database.database().reference().child("category").child((current?.uid)!).child(category.key) //removes category
        
        let catRef2 = Database.database().reference().child("listItem").child((current?.uid)!).child(category.key) //removing categoryReference in listItems
        
        
        
        catRef.removeValue()
    }
}

extension MainPageViewController: CollectionViewDelegate {
    func delete(cell: CollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
                    //1. delte the cell from our data source
        
                    
        
                    //2. delete the cell from out collection view
                    collectionView.deleteItems(at: [indexPath])
        }
         print("in delete function")
    }
}

extension MainPageViewController: ViewCategoryDelegate {
    func didTapCompleteButton(_ completeButton: UIButton, on cell: ViewCategoryTableViewCell) {
        print("did tap complete button")
    }
}

