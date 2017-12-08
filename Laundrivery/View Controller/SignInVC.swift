//
//  SignInVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class SignInVC: UIViewController , UITextFieldDelegate{
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
            guard error == nil
            else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            
            guard let users = user else {return}
            
            DatabaseService.shared.profile.child(users.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapDict = snapshot.value as? [String: Any] else {return}
                let userData = UserData(user: users, dict: snapDict)
                DatabaseService.shared.addUser(user: userData)
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
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField==emailTF {
            passwordTF.becomeFirstResponder()
        }
        else{
            self.becomeFirstResponder()
            self.signInDidTapped(textField)
        }
        return false
    }
    
    override func viewDidLoad() {
        emailTF.delegate=self
        passwordTF.delegate=self
    }
}





























