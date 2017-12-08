//
//  TypeTableViewCell.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 07/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    @IBAction func buttonDidTapped(_ sender: Any) {
        let type = self.type.text!
        let quantity = Int(self.quantity.text!)!
        if  quantity > 0 {
            DatabaseService.shared.addToCart(type: type, quantity: quantity)
            self.quantity.text = "\(0)"
        }
    }
    
    @IBAction func minusDidTapped(_ sender: Any) {
        let current = Int(quantity.text!)!
        if current > 0 {
            quantity.text = "\(current - 1)"
        }
    }
    
    @IBAction func plusDidTapped(_ sender: Any) {
        let current = Int(quantity.text!)!
        if current < 99 {
            quantity.text = "\(current + 1)"
        }
    }
}
