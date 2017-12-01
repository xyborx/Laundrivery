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
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("go to next")
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
}

