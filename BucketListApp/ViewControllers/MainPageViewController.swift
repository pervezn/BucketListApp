//
//  MainPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import Foundation
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
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 19)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.myOrangeColor()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        editButtonItem.tintColor = UIColor.myOrangeColor()
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleLabel.text = "Bucket List"
        titleLabel.textColor = UIColor.myOrangeColor()
        titleLabel.layer.zPosition = 1000
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
           // print("arrayOfCategories.count in numberOfItemsInSection is: \(arrayOfCategories.count)")
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
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
            cell.delegate = self
            cell.deleteButtonBackgroundView.layer.cornerRadius = cell.deleteButtonBackgroundView.bounds.width / 2.0
            cell.deleteButtonBackgroundView.layer.masksToBounds = true
            cell.deleteButtonBackgroundView.isHidden = !isEditing
            cell.titleButton.setTitle(arrayOfCategories[indexPath.row].categoryTitle, for: [])
           // cell.titleButton.setTitleColor(UIColor.myOrangeColor(), for: .normal)
            cell.titleButton.titleLabel?.numberOfLines = 0; // Dynamic number of lines
           
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCollectionViewCell", for: indexPath) as! AddCollectionViewCell
            
            
            cell.addButton.setTitleColor(UIColor.myTanColor(), for: .normal)
            
             
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
                
                viewCategory.title = currentCategory.categoryTitle
                

                
               
                
                ListItemService.showListItems(current!, catID: currentCategory.key) { (listItem) in
                    if let liIt = listItem {
                        arrayOfListItems2 = liIt
                        //print("In the main \(arrayOfListItems2.count)")
                        viewCategory.viewTableView.reloadData()
                        viewCategory.currentCategory = currentCategory
                       
                    }
                }
                //Work for Thursday!!!
            } else if identifier == "newCategory" {
                // print("Transitioning to the new Catergory View Controller")
                arrayOfListItems2.removeAll()
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
    
    static func removeCategory(category: Category) {
        let current = Auth.auth().currentUser
       // FIRUser.cre
    
        let catRef = Database.database().reference().child("category").child((current?.uid)!).child(category.key) //removes category
        
        let catRef2 = Database.database().reference().child("listItem").child((current?.uid)!).child(category.key) //removing categoryReference in listItems
        let catRef3 = Database.database().reference().child("users").child((current?.uid)!).child("categories") //removing categories from
        
        var catArraySub = [""]
        //print("User.current.categories?.count is:\(User.current.categories)")
    //need a different way to access the user
        
        catRef3.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let catArray = snapshot.value as? [String] else {
                //print("error: array doesn't exist")
                return
            }
            
            for i in 0...(catArray.count) - 1 {
                if catArray[i] == category.key {
                    catArraySub = catArray
                    catArraySub.remove(at: i)
                    break
                }
            }
            
             catRef3.setValue(catArraySub) //still doesn't work
        })
        
        
        catRef.removeValue()
        catRef2.removeValue()
       
    }
    
}

extension MainPageViewController: CollectionViewDelegate {
    func delete(cell: CollectionViewCell) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete this list?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { (action) in
            //somehow delete stuff!!
            if let indexPath = self.collectionView?.indexPath(for: cell) {
                
                MainPageViewController.removeCategory(category: arrayOfCategories[indexPath.item])
                arrayOfCategories.remove(at: indexPath.item)
                self.collectionView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension UIColor
{
    class func myOrangeColor() -> UIColor
    {
        return UIColor(red:0.95, green:0.67, blue:0.57, alpha:1.0)

       // return UIColor(red:CGFloat(235)/255, green: CGFloat(229)/255, blue: CGFloat(221)/255, alpha:1.0)
    }
    
    class func myTanColor() -> UIColor {
       return UIColor(red:0.87, green:0.82, blue:0.64, alpha:1.0)
    }
}

























