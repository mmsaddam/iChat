//
//  LoginViewController.swift
//  iChat
//
//  Created by Muzahidul Islam on 2/5/18.
//  Copyright © 2018 Muzahidul Islam. All rights reserved.
//

import UIKit
import FirebaseAuth

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Constants
    let loginToList = "LoginToContacts"
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldLoginEmail.text = "mmsaddam@gmail.com"
        textFieldLoginPassword.text = "qqqqqqqq"

        if let user = Auth.auth().currentUser {
            Session.loggedUser = user.asContact()
            Route.setAppTabBarAsRoot()
        }

    }

    deinit {
        print("Login deinit")
    }

    // MARK: Actions
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        print(#function)
        guard let email = textFieldLoginEmail.text, let password = textFieldLoginPassword.text else { return  }
        spinner.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, error) in
            self?.spinner.stopAnimating()
            if error != nil {
                print("login failed...")
            } else {
                print("signin success...")
                let contact = user?.asContact()
                Session.loggedUser = contact
                Route.setAppTabBarAsRoot()
            }
        }
        
    }
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "LoginToEmail", sender: self)
    }
    
}



