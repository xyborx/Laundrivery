//
//  HistoryVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase

class HistoryVC: UIViewController {
    @IBOutlet weak var sorryView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            self.navigationController?.isNavigationBarHidden = true
            sorryView.isHidden = false
        }
        else {
            
            sorryView.isHidden = true
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
