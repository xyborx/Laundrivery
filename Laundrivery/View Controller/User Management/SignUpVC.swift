//
//  SignUpVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class SignUpVC: UIViewController, UITextFieldDelegate {
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
            UtilitiesFunction.showAlert(self, title: "Missing Information", message: "Please fill out all fields")
            return
        }
        
        guard
            let repeatPassword = passwordTF.text, repeatPassword == password
        else {
            UtilitiesFunction.showAlert(self, title: "Password Mismatch", message: "Password must be the same")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard
                error == nil
                else {
                    UtilitiesFunction.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
            }
            guard let user = user else {return}
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                guard
                    error == nil
                    else {
                        UtilitiesFunction.showAlert(self, title: "Error", message: error!.localizedDescription)
                        return
                }
                DatabaseService.shared.userSignUp()
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
            emailTF.becomeFirstResponder()
        }
        else if textField == emailTF {
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF {
            repeatPasswordTF.becomeFirstResponder()
        }
        else {
            self.becomeFirstResponder()
            self.signUpDidTapped(textField)
        }
        return false
    }
    
    override func viewDidLoad() {
        nameTF.delegate=self
        emailTF.delegate=self
        passwordTF.delegate=self
        repeatPasswordTF.delegate=self
    }
}









































