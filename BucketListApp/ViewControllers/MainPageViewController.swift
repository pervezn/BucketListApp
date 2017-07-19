//
//  MainPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    


    @IBOutlet weak var collectionView: UICollectionView!
    var numberOfCollection1 = Category.arrayOfCategoryNames.count + 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCollection1
    
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("number of category names is: \(Category.arrayOfCategoryNames.count)")
        if Category.arrayOfCategoryNames.count + 1 == numberOfCollection1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCollectionViewCell", for: indexPath) as! AddCollectionViewCell
            print("in first if")
            return cell
       }
        print("in cellForRowAt")
        
        if indexPath.row != Category.arrayOfCategoryNames.count - 1 { //if it's not the last cell
            //print("number of category names is: \(Category.arrayOfCategoryNames.count)---Part 2")
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as!CollectionViewCell
            cell.delegate = self
            cell.deleteButtonBackgroundView.layer.cornerRadius = cell.deleteButtonBackgroundView.bounds.width / 2.0
            cell.deleteButtonBackgroundView.layer.masksToBounds = true
            cell.deleteButtonBackgroundView.isHidden = !isEditing
            return cell
        } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCollectionViewCell", for: indexPath) as! AddCollectionViewCell
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // print("in prepare")
        // 1
        if let identifier = segue.identifier {
            if identifier == "viewCategory" {
                print("Transitioning to the view Catergory View Controller")
            } else if identifier == "newCategory" {
               print("Transitioning to the new Catergory View Controller")
            }
            else if identifier == "cancel" {
                print("Cancel button tapped")
            } else if identifier == "save" {
               print("Save button tapped")
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
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
}

extension MainPageViewController: CollectionViewDelegate {
    func delete(cell: CollectionViewCell) {
//        if let indexPath = collectionView?.indexPath(for: cell) {
//            //1. delte the cell from our data source
//            
//            //arrayOfListNames[indexPath.section].(..imageNames..).remove(at: indexPath.item)
//            
//            //2. delete the cell from out collection view
//            collectionView.deleteItems(at: [indexPath])
//        }
        print("in delete function")
    }
}

extension MainPageViewController: ViewCategoryDelegate {
    func didTapCompleteButton(_ completeButton: UIButton, on cell: ViewCategoryTableViewCell) {
        print("did tap complete button")
    }
}
