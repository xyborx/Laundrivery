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

    init? (user: User, dict: [String: Any]) {
        self.userId = user.uid
        self.displayName = user.displayName ?? "Not set"
        self.email = user.email ?? "Not set"
        guard
            let phone = dict["phone"] as? String,
            let address = dict["address"] as? String
        else {
                return nil
        }
        self.phone = phone
        self.address = address
    }
}
