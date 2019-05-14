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

        // Do any additional setup after loading the view.
        
        logoutBu.layer.cornerRadius = 6
        
        guard let userEmailText = defaults.value(forKey: "userEmail") as? String else {return}
        userEmail.text = userEmailText
        
//        if defaults.value(forKey: "userEmail") != nil {
//            userEmail.text = defaults.val
//        }
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            ServiceLayer.logMeOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
