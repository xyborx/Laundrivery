//
//  ForgetPasswordVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var emailTF: UITextField!
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==emailTF {
            self.becomeFirstResponder()
            self.resetPasswordDidTapped(textField)
        }
        return false
    }
}
