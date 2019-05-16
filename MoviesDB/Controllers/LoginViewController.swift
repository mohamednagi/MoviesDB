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
    @IBOutlet weak var registerBu: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // checking if user is logged in or not
         Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                // caching logged user info locally
                UserDefaults.standard.set(user?.email, forKey: "userEmail")
                ServiceLayer.walkMeHome(view: self)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making some rounded corners
        loginBu.layer.cornerRadius = 6
        registerBu.layer.cornerRadius = 6
    }
    
    // presenting error alert to notify user of some thing bad happened
    func errorMessage(title: String, message: String) {
        let controller = UIAlertController(title: title, message: "\(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //checking if mail valid and password text not empty first
        if emailTxtField.text != "" {
            if passwordTxtField.text != "" {
                Auth.auth().signIn(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { [weak self] user, error in
                    if user != nil {
                        // saving user's email locally with userdefaults (small data no need for coredata)
                    defaults.set(self!.emailTxtField.text!, forKey: "userEmail")
                        // sign user into application home view
                    ServiceLayer.walkMeHome(view: self!)
                    } else {
                        // present error to user
                        self!.errorMessage(title: "Error", message: (error?.localizedDescription)!)
                    }
                }
            }else {
                errorMessage(title: "Error", message: "please enter your password")
            }
        }else {
            errorMessage(title: "Error", message: "please enter your email")
        }
        
    }
    
    // handling first step of app by registering user to firebase account
    @IBAction func registerAction(_ sender: UIButton) {
        //checking if mail valid and password text not empty
        if (emailTxtField.text?.isValidEmail())! {
            if passwordTxtField.text != "" {
                Auth.auth().createUser(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { authResult, error in
                    if error == nil {
                        // if no error occured cache user's email locally then go home view
                        defaults.set(self.emailTxtField.text!, forKey: "userEmail")
                        ServiceLayer.walkMeHome(view: self)
                    }else {
                        // present error to user
                        self.errorMessage(title: "Error", message: (error?.localizedDescription)!)
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
