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
//            UIApplication.shared.delegate.get
            total.text = "\(UtilitiesFunction.getStringPrice(price * (current - 1)))"
        }
    }
    
    @IBAction func plusDidTapped(_ sender: Any) {
        let current = Int(quantity.text!)!
        if current < 99 {
            quantity.text = "\(current + 1)"
            total.text = "\(UtilitiesFunction.getStringPrice(price * (current + 1)))"
        }
    }
}
