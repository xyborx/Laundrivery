//
//  UserInfo.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

struct UserInfo{
    let userId: String
    var image: UIImage?
    var displayName: String
    var email: String
    var phone: String?
    var address: String?
    
    init(userId: String, image: UIImage, displayName: String, email: String, phone: String, address: String) {
        self.userId = userId
        self.image = image
        self.displayName = displayName
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    init(userId: String, displayName: String, email: String, phone: String, address: String) {
        self.userId = userId
        self.displayName = displayName
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    init(userId: String, displayName: String, email: String) {
        self.userId = userId
        self.displayName = displayName
        self.email = email
    }
}
