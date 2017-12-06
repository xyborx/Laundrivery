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
            
            let newUser = UserData(userId: user.uid, displayName: name, email: email, phone: "", address: "")
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                guard
                    error == nil
                    else {
                        AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                        return
                }
                
                DatabaseService.shared.addUser(user: newUser)
                DatabaseService.shared.saveUserToCloud(uid: newUser.userId, phone: newUser.phone, address: newUser.address)
                
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
        if textField==nameTF {
            emailTF.becomeFirstResponder()
        }
        else if textField==emailTF{
            passwordTF.becomeFirstResponder()
        }
        else if textField==passwordTF{
            repeatPasswordTF.becomeFirstResponder()
        }
        else{
            self.becomeFirstResponder()
            self.signUpDidTapped(textField)
        }
        return false
    }
}









































