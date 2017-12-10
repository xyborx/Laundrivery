//
//  EditProfileVC.swift
//  Laundrivery
//
//  Created by Jefebry Dale Todingbunga Tanan on 06/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import GooglePlacePicker
import TGCameraViewController
import Firebase

class EditProfileVC: UIViewController, UITextFieldDelegate, GMSPlacePickerViewControllerDelegate, TGCameraDelegate {
    
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressLabel: UIButton!
    
    @IBAction func saveChangesDidTapped(){
        
    }
    
    let currentUser = DatabaseService.shared.getUser()!
    
    override func viewDidLoad() {
        //Profile data
        fullNameTF.text = currentUser.displayName
        fullNameTF.placeholder = currentUser.displayName
        emailTF.text = currentUser.email
        emailTF.placeholder = currentUser.email
        phoneTF.text = currentUser.phone
        phoneTF.placeholder = currentUser.phone ?? "Not Set"
        addressLabel.setTitle(currentUser.address  ?? "Not Set", for: .normal)
        //Image button
        imgButton.layer.cornerRadius = 0.5 * imgButton.bounds.size.width
        imgButton.clipsToBounds = true
        imgButton.contentMode = .center
        //Camera setting
        TGCameraColor.setTint(.white)
        super.viewDidLoad()
    }
    
    @IBAction func imgDidTapped(_ sender: Any) {
        let navigationController = TGCameraNavigationController.new(with: self)
        present(navigationController!, animated: true, completion: nil)
    }
    
    @IBAction func addressDidTapped(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        if let address = place.formattedAddress {
            self.addressLabel.setTitle(address, for: .normal)
        }
        else {
            
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func cameraDidCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func cameraDidTakePhoto(_ image: UIImage!) {
        if UtilitiesFunction.saveImage(image: image, named: "") {
            imgButton.setImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(_ image: UIImage!) {
        if UtilitiesFunction.saveImage(image: image, named: "") {
            imgButton.setImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
