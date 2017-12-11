//
//  CheckOutCart.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class CheckOutCart: UIViewController {
    @IBOutlet weak var cartTable: UITableView!
    
    var cart: [CartItem] = DatabaseService.shared.getCartItems()
    
    override func viewDidLoad() {
        cartTable.separatorStyle = .none
        super.viewDidLoad()
    }
}

extension CheckOutCart: UITableViewDataSource {
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
