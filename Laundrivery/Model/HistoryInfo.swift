//
//  History.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 11/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation

struct HistoryInfo {
    let date: Date
    let orderId: String
    let order: [CartItem]
    let pickUpAddress: String
    let deliveryAddress: String
    var status: String
    
    init(date: Date, orderId: String, order: [CartItem], pickUpAddress: String, deliveryAddress: String, status: String) {
        self.date = date
        self.orderId = orderId
        self.order = order
        self.pickUpAddress = pickUpAddress
        self.deliveryAddress = deliveryAddress
        self.status = status
    }
}
