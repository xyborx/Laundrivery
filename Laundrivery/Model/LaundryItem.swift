//
//  LaundryItem.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

struct LaundryItem {
    let category: String
    let type: String
    let price: Int
    
    init(category: String, type: String, price: Int) {
        self.category = category
        self.type = type
        self.price = price
    }
}
