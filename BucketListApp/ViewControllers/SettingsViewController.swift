//
//  SettingsViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var attributionsButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        attributionsButton.layer.cornerRadius = 3
        attributionsButton.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func unwindToSettingsPageViewController(_ segue: UIStoryboardSegue) {
        
    }
}
