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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartTable.separatorInset = UIEdgeInsets.zero
        cartTable.layoutMargins = UIEdgeInsets.zero
    }
    
    @IBAction func checkOutDidTapped(_ sender: Any) {
        if cart.isEmpty {
            UtilitiesFunction.showAlert(self, title: "Error", message: "Please add something into your cart first")
            return
        }
        self.performSegue(withIdentifier: "checkOutSegue", sender: nil)
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
