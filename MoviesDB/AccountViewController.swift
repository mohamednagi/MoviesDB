//
//  AccountViewController.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var logoutBu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        logoutBu.layer.cornerRadius = 6
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
    }
    
}
