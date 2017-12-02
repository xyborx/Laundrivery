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
//        rgba(52, 63, 75, 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 52.0/255.0, green: 63.0/255.0, blue: 75.0/255.0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        tabBarController?.tabBar.tintColor = UIColor.white
        
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

