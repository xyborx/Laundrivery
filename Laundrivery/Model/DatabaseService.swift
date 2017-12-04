//
//  DatabaseService.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 04/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let profile = Database.database().reference().child("profile")
    let history = Database.database().reference().child("history")
}
