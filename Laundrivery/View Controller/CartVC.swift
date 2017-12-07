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
//        DatabaseService.shared.addToCart(type: "Shirt", quantity: 5)
//        DatabaseService.shared.addToCart(type: "Batik", quantity: 7)
        cart = DatabaseService.shared.getCartItems()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartTable.separatorInset = UIEdgeInsets.zero
        cartTable.layoutMargins = UIEdgeInsets.zero
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! CartTableViewCell
        cell.itemName.text = cart[indexPath.row].type
        cell.quantity.text = "\(cart[indexPath.row].quantity)"
        cell.total.text = "Rp \(cart[indexPath.row].quantity * cart[indexPath.row].price)"
        return cell
    }
    
    
}
