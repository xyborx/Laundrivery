//
//  DatabaseService.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 04/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import Foundation
import Firebase
import CoreData

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let profile = Database.database().reference().child("profile")
    let history = Database.database().reference().child("history")
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getUser(uid: String) -> UserData {
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "uid == %@", uid)
        request.returnsObjectsAsFaults = false
        do {
            let data = try container.fetch(request) as! [NSManagedObject]
            guard
                let userId = data[0].value(forKey: "uid") as? String,
                let name = data[0].value(forKey: "name") as? String,
                let email = data[0].value(forKey: "email") as? String,
                let phone = data[0].value(forKey: "phone") as? String,
                let address = data[0].value(forKey: "address") as? String
            else {
                return UserData()
            }
            return UserData(userId: userId, displayName: name, email: email, phone: phone, address: address)
        } catch {
            print("Failed")
        }
        return UserData()
    }
    
    func getUsers() -> [UserData] {
        var userData: [UserData] = [UserData]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let userId = data.value(forKey: "uid") as? String,
                    let name = data.value(forKey: "name") as? String,
                    let email = data.value(forKey: "email") as? String,
                    let phone = data.value(forKey: "phone") as? String,
                    let address = data.value(forKey: "address") as? String
                else {
                    continue
                }
                userData.append(UserData(userId: userId, displayName: name, email: email, phone: phone, address: address))
            }
        } catch {
            print("Failed")
        }
        return userData
    }
    
    func addUser(user: UserData) {
        let container = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: container)
        let newUser = NSManagedObject(entity: entity!, insertInto: container)
        newUser.setValue(user.userId, forKey: "uid")
        newUser.setValue(user.displayName, forKey: "name")
        newUser.setValue(user.email, forKey: "email")
        newUser.setValue(user.phone, forKey: "phone")
        newUser.setValue(user.address, forKey: "address")
        do {
            try container.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func saveUserToCloud(uid: String, phone: String, address: String) {
        let parameters = ["phone"    : phone,
                          "address"        : address]
        profile.child(uid).setValue(parameters)
    }
}
