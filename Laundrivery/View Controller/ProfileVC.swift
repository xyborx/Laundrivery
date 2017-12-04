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
        if Auth.auth().currentUser == nil {
            self.navigationController?.isNavigationBarHidden = true
            profileView.isHidden = true
            sorryView.isHidden = false
        }
        else {
            guard let name = Auth.auth().currentUser?.displayName else {return}
            guard let email = Auth.auth().currentUser?.email else {return}
            nameLabel.text = name
            emailLabel.text = email
            profileView.isHidden = false
            sorryView.isHidden = true
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
