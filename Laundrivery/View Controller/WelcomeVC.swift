//
//  WelcomeVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if loggedIn {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "doneAuth", sender: nil)
            }
        }
        let finishTutorial = UserDefaults.standard.bool(forKey: "finishTutorial")
        if finishTutorial {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "skipTutorial", sender: nil)
            }
            
        }
    }
}
