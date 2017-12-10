//
//  WelcomeVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
        let launched = UserDefaults.standard.bool(forKey: "launched")
        if !launched {
            DatabaseService.shared.initiate()
            UserDefaults.standard.set(true, forKey: "launched")
        }
        else{
            DatabaseService.shared.initiateLaunched()
        }
        let finishTutorial = UserDefaults.standard.bool(forKey: "finishTutorial")
        if finishTutorial {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Menu", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuSB")
            DispatchQueue.main.async {
                self.present(newViewController, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func skipTutorialDidTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "finishTutorial")
    }
}
