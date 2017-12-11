//
//  CheckOutVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import GooglePlacePicker

class CheckOutVC: UIViewController, GMSPlacePickerViewControllerDelegate {
    @IBOutlet weak var order: UIButton!
    @IBOutlet weak var pickUp: UIButton!
    @IBOutlet weak var delivery: UIButton!
    @IBOutlet weak var button: UIButton!
    
    let user = DatabaseService.shared.getUser()!
    let carts = DatabaseService.shared.getCartItems()
    var caller: String?
    
    override func viewWillAppear(_ animated: Bool) {
        var order = 0
        var price = 0
        for cart in carts {
            if cart.quantity != 0 {
                order += 1
                price += cart.detail.price * cart.quantity
            }
        }
        self.order.setTitle("\(order) Order(s) Total \(UtilitiesFunction.getStringPrice(price))", for: .normal)
    }
    
    @IBAction func cancelDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setPickUpDidTapped(_ sender: Any) {
        let profile = UIAlertAction(title: "Use my profile address", style: .default) { _ in
            if self.user.address == nil {
                UtilitiesFunction.showAlert(self, title: "Error", message: "Profile address is not set")
                return
            }
            self.pickUp.setTitle(self.user.address, for: .normal)
        }
        let select = UIAlertAction(title: "Select new address", style: .default) { _ in
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            self.caller = "pickup"
            self.present(placePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let alertController = UIAlertController(title: "Select option", message: "", preferredStyle: .alert)
        alertController.addAction(profile)
        alertController.addAction(select)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func setDeliveryDidTapped(_ sender: Any) {
        let profile = UIAlertAction(title: "Use my profile address", style: .default) { _ in
            if self.user.address == nil {
                UtilitiesFunction.showAlert(self, title: "Error", message: "Profile address is not set")
                return
            }
            self.delivery.setTitle(self.user.address, for: .normal)
        }
        let select = UIAlertAction(title: "Select new address", style: .default) { _ in
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            self.caller = "delivery"
            self.present(placePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let alertController = UIAlertController(title: "Select option", message: "", preferredStyle: .alert)
        alertController.addAction(profile)
        if self.pickUp.titleLabel?.text != "Set Pick-Up Address" {
            let same = UIAlertAction(title: "Same as pick-up address", style: .default) { _ in
                self.delivery.setTitle(self.pickUp.titleLabel?.text, for: .normal)
            }
            alertController.addAction(same)
        }
        alertController.addAction(select)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func placeOrderDidTapped(_ sender: Any) {
        DatabaseService.shared.addHistory(cartItems: self.carts, pickUpAddres: (self.pickUp.titleLabel?.text)!, deliveryAddress: (self.delivery.titleLabel?.text)!)
        self.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        if self.caller! == "pickup"{
            self.pickUp.setTitle(place.formattedAddress, for: .normal)
        }
        else {
            self.delivery.setTitle(place.formattedAddress, for: .normal)
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
