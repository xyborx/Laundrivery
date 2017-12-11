//
//  SettingsVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    @IBAction func signOutDidTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            DatabaseService.shared.wipeOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("Laundrivery Error]:[Failed in 'signOutDidTapped(_ sender: Any)']")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
