//
//  MainPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayOfListNames = ["Restaurants", "citites", "Parks", "Countries", "Arenas"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
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
        return arrayOfListNames.count
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as!CollectionViewCell
        var cell = UICollectionViewCell()
        // print(arrayOfListNames.count)
        if indexPath.row != arrayOfListNames.count - 1 {
           // print(arrayOfListNames.count)
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as!CollectionViewCell
            //cell.delegate = self
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCollectionViewCell", for: indexPath) as! AddCollectionViewCell
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in prepare")
        // 1
        if let identifier = segue.identifier {
            if identifier == "viewCategory" {
                print("Transitioning to the view Catergory View Controller")
            } else if identifier == "newCategory" {
                print("Transitioning to the new Catergory View Controller")
            } else if identifier == "cancel" {
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
        if let indexPath = collectionView?.indexPath(for: cell) {
            //1. delte the cell from our data source
            
            //arrayOfListNames[indexPath.section].(..imageNames..).remove(at: indexPath.item)
            
            //2. delete the cell from out collection view
            collectionView.deleteItems(at: [indexPath])
        }
    }
}

extension MainPageViewController: ViewCategoryDelegate {
    func didTapCompleteButton(_ completeButton: UIButton, on cell: ViewCategoryTableViewCell) {
        print("did tap complete button")
    }
}
