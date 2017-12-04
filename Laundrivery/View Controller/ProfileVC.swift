//
//  ProfileVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBAction func signOutDidTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "loggedIn")
            performSegue(withIdentifier: "signOutSegue", sender: nil)
        }
        catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let name = Auth.auth().currentUser?.displayName else {return}
        guard let email = Auth.auth().currentUser?.email else {return}
        nameLabel.text = name
        emailLabel.text = email
    }
}
