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
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var sorryView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            guard let name = currentUser.displayName else {return}
            guard let email = currentUser.email else {return}
            DatabaseService.shared.profile.child(uid).observe(.value, with: { (snapshot) in
                print(snapshot)
                guard
                    let data = snapshot.value as? [String: Any],
                    let address = data["address"] as? String,
                    let phone = data["phone"] as? String
                else {
                    return
                }
                self.nameLabel.text = name
                self.emailLabel.text = email
                self.phoneLabel.text = phone
                self.streetLabel.text = address
            })
            profileView.isHidden = false
            sorryView.isHidden = true
        }
        else {
            self.navigationController?.isNavigationBarHidden = true
            profileView.isHidden = true
            sorryView.isHidden = false
        }
    }
    
    @IBAction func signOutDidTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.viewWillAppear(true)
        }
        catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            self.navigationController?.isNavigationBarHidden = false
        }
    }
}
