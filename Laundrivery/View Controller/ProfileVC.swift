//
//  ProfileVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class ProfileVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var sorryView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let currentUser = Auth.auth().currentUser {
            let user = DatabaseService.shared.getUser(uid: currentUser.uid)
            nameLabel.text = user.displayName
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            streetLabel.text = user.address
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
