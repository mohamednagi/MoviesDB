//
//  AccountViewController.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var logoutBu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making some rounded corners
        logoutBu.layer.cornerRadius = 6
        
        // checking for cached data first
        guard let userEmailText = defaults.value(forKey: "userEmail") as? String else {return}
        userEmail.text = userEmailText
    }
    
    // occurs when user click logout button
    @IBAction func logoutAction(_ sender: UIButton) {
        // clearing cached data (userDefaults)
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        // logging out from firebase to expire user
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // directing user to login view
            ServiceLayer.logMeOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
