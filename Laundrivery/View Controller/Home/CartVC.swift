//
//  CartVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var cartTable: UITableView!
    
    var cart: [CartItem] = [CartItem]()

    override func viewDidLoad() {
        cart = DatabaseService.shared.getCartItems()
        cartTable.separatorStyle = .none
        
        super.viewDidLoad()
    }
    
    @IBAction func checkOutDidTapped(_ sender: Any) {
        if DatabaseService.shared.getUser() == nil {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Please sign in before check out")
            return
        }
        if cart.isEmpty {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Please add something into your cart first")
            return
        }
        DatabaseService.shared.updateCartItem()
        self.navigationController?.popToRootViewController(animated: true)
        self.performSegue(withIdentifier: "checkOutSegue", sender: nil)
    }
    
    func deleteData(type: String) {
        for ind in 0..<cart.count {
            if cart[ind].detail.type == type {
                let indexPath = IndexPath(item: ind, section: 0)
                cartTable.deleteRows(at: [indexPath], with: .fade)
                break
            }
        }
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! CartTableViewCell
        let item = cart[indexPath.row]
        cell.itemName.text = item.detail.type
        cell.quantity.text = "\(item.quantity)"
        cell.total.text = "\(UtilitiesFunction.getStringPrice(item.quantity * item.detail.price))"
        cell.price = item.detail.price
        return cell
    }
}
