//
//  SignInVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func signInDidTapped(_ sender: Any) {
        guard
            let email = emailTF.text, email != "",
            let password = passwordTF.text, password != ""
            else {
                AlertController.showAlert(self, title: "Missing Information", message: "Please fill out all fields")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard
                error == nil
                else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
            }
            
            guard
                let user = user
                else {
                    return
            }
            
            print(user.email ?? "Missing email")
            print(user.displayName ?? "Missing display name")
            print(user.uid)
            
            UserDefaults.standard.set(true, forKey: "loggedIn")
            self.performSegue(withIdentifier: "doneAuth", sender: nil)
        }
    }
}
