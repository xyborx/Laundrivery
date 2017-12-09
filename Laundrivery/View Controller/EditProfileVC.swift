//
//  EditProfileVC.swift
//  Laundrivery
//
//  Created by Jefebry Dale Todingbunga Tanan on 06/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import GooglePlacePicker

class EditProfileVC: UIViewController, UITextFieldDelegate, GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressLabel: UIButton!
    
    @IBAction func saveChangesDidTapped(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgButton.layer.cornerRadius = 0.5 * imgButton.bounds.size.width
        imgButton.clipsToBounds = true
        imgButton.contentMode = .center
    }
    
    @IBAction func imgDidTapped(_ sender: Any) {
        
    }
    
    @IBAction func addressDidTapped(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
