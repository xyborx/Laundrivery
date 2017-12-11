//
//  ChangePasswordVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordVC: UIViewController {
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var button: UIButton!
    
    let user = DatabaseService.shared.getUser()!
    
    @IBAction func changeDidTapped(_ sender: Any) {
        guard
            let currentPassword = currentPasswordTF.text, currentPassword != "",
            let newPassword = currentPasswordTF.text, newPassword != "",
            let repeatPassword = repeatPasswordTF.text, repeatPassword != ""
        else {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Please fill the data")
            return
        }
        /*if newPassword != repeatPassword {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Password Mismatch")
            return
        }*/
        let credential = EmailAuthProvider.credential(withEmail: user.email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential) { error in
            if let error = error {
                print("[Laundrivery Error]:[Failed in 'changeDidTapped(_ sender: Any)->reauthenticate(with: credential)']:[\(error.localizedDescription)]")
                return
            }
            Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
                if let error = error {
                    print("[Laundrivery Error]:[Failed in 'changeDidTapped(_ sender: Any)->updatePassword(to: newPassword)']:[\(error.localizedDescription)]")
                    return
                }
                self.navigationController?.popViewController(animated: true)
                UtilitiesFunction.showAlert(self, title: "Success", message: "Change Password Success")
            }
        }
    }
}
