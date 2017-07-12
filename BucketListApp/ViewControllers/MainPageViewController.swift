//
//  MainPageViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayOfListNames = ["Restaurants", "citites", "Parks", "Countries", "Arenas","Restaurants", "citites", "Parks", "Countries", "Arenas"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
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
            //print("here")
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
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
}
