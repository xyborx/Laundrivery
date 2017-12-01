//
//  ViewController.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 28/11/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let finishTutorial = UserDefaults.standard.bool(forKey: "finishTutorial")
        if finishTutorial  {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "skipTutorial", sender: nil)
            }
            
        } else {
//            UserDefaults.standard.set(true, forKey: "finishTutorial")
        }
    }
}

