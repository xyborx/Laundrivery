//
//  ChangeEmailVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class ChangeEmailVC: UIViewController {
    @IBOutlet weak var currentEmailTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var button: UIButton!
    
    let user = DatabaseService.shared.getUser()!
    
    override func viewDidLoad() {
        currentEmailTF.isEnabled = false
        currentEmailTF.text = user.email
        super.viewDidLoad()
    }
    
    @IBAction func changeDidTapped(_ sender: Any) {
        guard
            let newEmail = newEmailTF.text, newEmail != "",
            let password = passwordTF.text, password != ""
        else {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Please fill the data")
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: user.email, password: password)
        Auth.auth().currentUser?.reauthenticate(with: credential) { error in
            if let error = error {
                print("[Laundrivery Error]:[Failed in 'changeDidTapped(_ sender: Any)->reauthenticate(with: credential)']:[\(error.localizedDescription)]")
                return
            }
            Auth.auth().currentUser?.updateEmail(to: newEmail) { (error) in
                if let error = error {
                    print("[Laundrivery Error]:[Failed in 'changeDidTapped(_ sender: Any)->updateEmail(to: newEmail)']:[\(error.localizedDescription)]")
                    return
                }
                DatabaseService.shared.updateEmail(email: newEmail)
                self.navigationController?.popViewController(animated: true)
                UtilitiesFunction.showAlert(self, title: "Success", message: "Change Email Success")
            }
        }
    }
}
