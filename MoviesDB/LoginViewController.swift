//
//  LoginViewController.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBu: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBu.layer.cornerRadius = 6
    }
    
    func errorMessage(title: String, message: String) {
        let controller = UIAlertController(title: title, message: "\(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if (emailTxtField.text?.isValidEmail())! {
            if passwordTxtField.text != "" {
                Auth.auth().createUser(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { authResult, error in
                    if error == nil {
                        print(authResult)
                    }else {
                        self.errorMessage(title: "Error", message: "error creating your profile")
                    }
                }
            }else {
                errorMessage(title: "Error", message: "please enter valid password")
            }
        }else {
            errorMessage(title: "Error", message: "please enter valid email")
        }
    }
    
}
