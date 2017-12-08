//
//  CartItem.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 07/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

class CartItem: TypeItem {
    var quantity: Int
    
    init(type: String, quantity: Int) {
        self.quantity = quantity
        super.init(type: type, price: DatabaseService.shared.getPrice(type: type))
    }
}
