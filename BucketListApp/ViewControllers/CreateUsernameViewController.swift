//
//  CreateUsernameViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/17/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        nextButton.layer.cornerRadius = 6
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return (true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        

        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        usernameTextField.resignFirstResponder()
    }
}
