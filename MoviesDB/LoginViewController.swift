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
        
         Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                ServiceLayer.walkMeHome(view: self)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBu.layer.cornerRadius = 6
        registerBu.layer.cornerRadius = 6
    }
    
    func errorMessage(title: String, message: String) {
        let controller = UIAlertController(title: title, message: "\(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    } //mohamed.nagi@brightcreations.com
    // aaaaaaaa
    @IBAction func loginAction(_ sender: UIButton) {
        
        if (emailTxtField.text?.isValidEmail())! {
            if passwordTxtField.text != "" {
                Auth.auth().signIn(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { [weak self] user, error in
                    if user != nil {
                    defaults.set(self!.emailTxtField.text!, forKey: "userEmail")
                    ServiceLayer.walkMeHome(view: self!)
                    } else {
                        self!.errorMessage(title: "Error", message: (error?.localizedDescription)!)
                    }
                } //mohamed.nagi@brightcreations.com
            }else {
                errorMessage(title: "Error", message: "please enter valid password")
            }
        }else {
            errorMessage(title: "Error", message: "please enter valid email")
        }
        
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        if (emailTxtField.text?.isValidEmail())! {
            if passwordTxtField.text != "" {
                Auth.auth().createUser(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { authResult, error in
                    if error == nil {
                        defaults.set(self.emailTxtField.text!, forKey: "userEmail")
                        ServiceLayer.walkMeHome(view: self)
                    }else {
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
