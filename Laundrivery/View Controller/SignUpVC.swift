//
//  SignUpVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    
    @IBAction func signUpDidTapped(_ sender: Any) {
        guard
            let name = nameTF.text, name != "",
            let email = emailTF.text, email != "",
            let password = passwordTF.text, password != ""
            else {
                AlertController.showAlert(self, title: "Missing Information", message: "Please fill out all fields")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
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
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                guard
                    error == nil
                    else {
                        AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                        return
                }
                UserDefaults.standard.set(true, forKey: "loggedIn")
                self.performSegue(withIdentifier: "doneAuth", sender: nil)
            })
        }
    }
}
