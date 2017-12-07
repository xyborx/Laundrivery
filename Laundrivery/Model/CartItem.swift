//
//  CartItem.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 07/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

class CartItem {
    let type: String
    let price: Int
    var quantity: Int
    
    init(type: String, quantity: Int) {
        let price = DatabaseService.shared.getPrice(type: type)
        self.type = type
        self.price = price
        self.quantity = quantity
    }
}
