//
//  AppDelegate.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/9/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import GooglePlaces
import GooglePlacePicker
import SwiftyJSON


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
//        GMSPlacesClient.provideAPIKey("AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M")
//        GMSServices.provideAPIKey("AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M")
        
//        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
//        
//        
//        var parameters : Parameters = [
//        "location":"bla"
//        ,"radius" : "50000"
//        , "types" :"food"
//        ,"name" : "cruise"
//        ,"key" : "AIzaSyAg0qIZOgb4PR8pYdgB1HRZKD2FWJDcG9M"]
//        
//        
//        
//        
//        Alamofire.request(url, parameters: parameters).validate().responseJSON() { response in
//            //print(response.request)
//            //print(request(url).response)
//           // print(response.result.value)
//            //print(response.result.error)
//            //print(response.request as Any)
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    print(json)
//                    let array = json["results"].arrayValue
//                    print("About to print array")
//                    for result in array {
//                        print(result["geometry"]["location"]["lat"].doubleValue)
//                    }
//                    // Do what you need to with JSON here!
//                    // The rest is all boiler plate code you'll use for API requests
//                    
//                    
//                }
//            case .failure(let error):
//                print(error)
//            }
//            }
        
       configureInitialRootViewController(for: window)
            
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if Auth.auth().currentUser != nil,
            let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            
            User.setCurrent(user)
            
            initialViewController = UIStoryboard.initialViewController(for: .main)
        } else {
            initialViewController = UIStoryboard.initialViewController(for: .login)
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

