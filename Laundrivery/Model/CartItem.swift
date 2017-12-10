//
//  CartItem.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 07/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

struct CartItem {
    let detail: LaundryItem
    var quantity: Int
    
    init(named item: String, quantity: Int) {
        self.detail = DatabaseService.shared.getLaundryItem(named: item)!
        self.quantity = quantity
    }
}
