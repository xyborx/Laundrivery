//
//  User.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 04/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation
import Firebase

class UserData {
    let userId: String
    let displayName: String
    let email: String
    let phone: String
    let address: String

    init(user: Firebase.User, dict: [String: Any]) {
        self.userId = user.uid
        self.displayName = user.displayName ?? "Not set"
        self.email = user.email ?? "Not set"
        let phone = dict["phone"] as? String
        let address = dict["address"] as? String
        self.phone = phone!
        self.address = address!
    }
    
    init(userId: String, displayName: String, email: String, phone: String, address: String) {
        self.userId = userId
        self.displayName = displayName
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    init() {
        self.userId = ""
        self.displayName = ""
        self.email = ""
        self.phone = ""
        self.address = ""
    }
}
