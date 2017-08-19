//
//  LoginViewController.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/17/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
import FBSDKLoginKit

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginButton.layer.cornerRadius = 2
        loginButton.clipsToBounds = true
        
        let fbLoginButton = FBSDKLoginButton()
        
        fbLoginButton.frame = CGRect(x: 0, y: 0, width: view.frame.width - 100, height: 40)
        
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fbLoginButton)
        
       
        fbLoginButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor, constant: 0).isActive = true
        fbLoginButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor, constant: 0).isActive = true
        fbLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        //fbLoginButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        fbLoginButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        
        
       //fbLoginButton.center.x = view.frame.width/2
      // let verticalSpace = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: fbLoginButton, attribute: .bottom, multiplier: 1, constant: 150)
   
      
        
        
        // activate the constraints
        //NSLayoutConstraint.activate([verticalSpace])
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
        
        //add custom login button
        
//        let customFBButton = UIButton()
//        customFBButton.backgroundColor = .blue
//        customFBButton.frame =  CGRect(x: 45, y: 425, width: view.frame.width - 100, height: 40)
//        customFBButton.setTitle("Custom FB login here", for: .normal)
//        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//        customFBButton.setTitleColor(.white, for: .normal)
//        view.addSubview(customFBButton)
//        
//        customFBButton.addTarget(self, action: #selector(handleCusotmFBLogin), for: .touchUpInside)
    }
    
    func handleCusotmFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Cusotm fb Login Failed", err)
                return
            }
            self.showEmailAddress()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {
            return
        }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error)
                return
            }
            
            print("Sucessfully logged in with out user", user ?? "")
            
            //let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
            guard let user = user
                else { return }
            
            let userRef = Database.database().reference().child("users").child(user.uid)
            
            
            userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
                if let user = User(snapshot: snapshot) {
                    User.setCurrent(user)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: .main)
                    if let initialViewController = storyboard.instantiateInitialViewController() {
                        self.view.window?.rootViewController = initialViewController
                    }
                } else {
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
            })
        })
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }
            print(result)//get the email address of your user
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                }
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        })
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
}
