//
//  CartTableViewCell.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 07/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total: UILabel!
    
    var price = 0
    
    @IBAction func minusDidTapped(_ sender: Any) {
        let current = Int(quantity.text!)!
        if current > 0 {
            quantity.text = "\(current - 1)"
            total.text = "\(UtilitiesFunction.getStringPrice(price * (current - 1)))"
            updateData()
        }
        else {
            let sp = self.superview?.superview as? CartVC
            sp?.deleteData(type: self.itemName.text!)
//            self.superview?.deleteData(self.itemName.text!)
        }
    }
    
    @IBAction func plusDidTapped(_ sender: Any) {
        let current = Int(quantity.text!)!
        if current < 99 {
            quantity.text = "\(current + 1)"
            total.text = "\(UtilitiesFunction.getStringPrice(price * (current + 1)))"
            updateData()
        }
    }
    
    func updateData() {
        let type = self.itemName.text!
        let quantity = Int(self.quantity.text!)!
        DatabaseService.shared.updateCartItem(type: type, quantity: quantity)
    }
}
