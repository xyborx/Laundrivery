//
//  WelcomeVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        let notFirstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        if !notFirstLaunch {
            DatabaseService.shared.initiate()
            UserDefaults.standard.set(true, forKey: "firstLaunch")
        }
        let finishTutorial = UserDefaults.standard.bool(forKey: "finishTutorial")
        if finishTutorial {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "skipTutorial", sender: nil)
            }
        }
    }
    
    @IBAction func skipTutorialDidTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "finishTutorial")
    }
}
