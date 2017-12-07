//
//  typeItem.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 08/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

class TypeItem {
    let category: String
    let type: String
    let desc: String
    let price: Int
    
    init(category: String, type: String, desc: String, price: Int) {
        self.category = category
        self.type = type
        self.desc = desc
        self.price = price
    }
}
