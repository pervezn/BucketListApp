//
//  SettingsViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet weak var attributionsButton: UIButton!
   
    @IBAction func logOutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            
            if Auth.auth().currentUser != nil {
                do {
                    try? Auth.auth().signOut()
                    
                    if Auth.auth().currentUser == nil {
                        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
                        
                        self.present(loginVC, animated: true, completion: nil)
                    }
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
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
