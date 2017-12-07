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
    
    func initiate() {
        let container = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.execute(batchDeleteRequest)
            let datas: [TypeItem] = [TypeItem(category: "Tops", type: "Shirt", desc: "", price: 10000),
                                    TypeItem(category: "Tops", type: "Batik", desc: "", price: 20000),
                                    TypeItem(category: "Tops", type: "Blouse", desc: "", price: 0),
                                    TypeItem(category: "Tops", type: "T-Shirt", desc: "", price: 0),
                                    TypeItem(category: "Tops", type: "Jacket", desc: "", price: 0),
                                    TypeItem(category: "Tops", type: "Coat", desc: "", price: 0),
                                    TypeItem(category: "Tops", type: "Sweater", desc: "", price: 0),
                                    TypeItem(category: "Trousers", type: "Trouser", desc: "", price: 0),
                                    TypeItem(category: "Trousers", type: "Jean", desc: "", price: 0),
                                    TypeItem(category: "Trousers", type: "Short", desc: "", price: 0),
                                    TypeItem(category: "Dresses", type: "Dress", desc: "", price: 0),
                                    TypeItem(category: "Dresses", type: "Skirt", desc: "", price: 0),
                                    TypeItem(category: "Dresses", type: "Kebaya", desc: "", price: 0),
                                    TypeItem(category: "Shoes", type: "Sneaker", desc: "", price: 0),
                                    TypeItem(category: "Shoes", type: "Canvas", desc: "", price: 0),
                                    TypeItem(category: "Shoes", type: "Suede", desc: "", price: 0),
                                    TypeItem(category: "Shoes", type: "Leather", desc: "", price: 0),
                                    TypeItem(category: "Shoes", type: "Hybrid", desc: "", price: 0),
                                    TypeItem(category: "Others", type: "Bag of Clothes", desc: "", price: 0),
                                    TypeItem(category: "Others", type: "Bed Sheet", desc: "", price: 0),
                                    TypeItem(category: "Others", type: "Blanked", desc: "", price: 0),
                                    TypeItem(category: "Others", type: "Bag", desc: "", price: 0)]
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: container)
            for data in datas {
                let newData = NSManagedObject(entity: entity!, insertInto: container)
                newData.setValue(data.category, forKey: "category")
                newData.setValue(data.type, forKey: "type")
                newData.setValue(data.desc, forKey: "desc")
                newData.setValue(data.price, forKey: "price")
                do {
                    try container.save()
                } catch {
                    print("Failed saving \(data.type)")
                }
            }
        } catch {
            print("Failed deleting")
        }
    }
    
    func getAllData() -> [TypeItem] {
        var allData = [TypeItem]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let category = data.value(forKey: "category") as? String,
                    let type = data.value(forKey: "type") as? String,
                    let desc = data.value(forKey: "desc") as? String,
                    let price = data.value(forKey: "price") as? Int
                    else {
                        continue
                }
                allData.append(TypeItem(category: category, type: type, desc: desc, price: price))
            }
        } catch {
            print("Failed")
        }
        return allData
    }
    
    func getAllData(with category: String) -> [TypeItem] {
        var allData = [TypeItem]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.predicate = NSPredicate(format: "category == %@", category)
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let category = data.value(forKey: "category") as? String,
                    let type = data.value(forKey: "type") as? String,
                    let desc = data.value(forKey: "desc") as? String,
                    let price = data.value(forKey: "price") as? Int
                    else {
                        continue
                }
                allData.append(TypeItem(category: category, type: type, desc: desc, price: price))
            }
        } catch {
            print("Failed")
        }
        return allData
    }
    
    func getCategoriesAndTypes() -> [String: [String: Int]] {
        var allData = [String: [String: Int]]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let category = data.value(forKey: "category") as? String,
                    let type = data.value(forKey: "type") as? String,
                    let price = data.value(forKey: "price") as? Int
                else {
                    continue
                }
                if !allData.keys.contains(category) {
                    allData[category] = [String: Int]()
                }
                allData[category]![type] = price
            }
        } catch {
            print("Failed")
        }
        return allData
    }
    
    func getCategories() -> [String] {
        var categories = [String]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let category = data.value(forKey: "category") as? String else {continue}
                if !categories.contains(category) {
                    categories.append(category)
                }
            }
        } catch {
            print("Failed")
        }
        return categories
    }
    
    func getTypes(category: String) -> [String] {
        var types = [String]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.predicate = NSPredicate(format: "category == %@", category)
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let type = data.value(forKey: "type") as? String else {continue}
                types.append(type)
            }
        } catch {
            print("Failed")
        }
        return types
    }
    
    func getPrice(type: String) -> Int {
        var price = -1
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.predicate = NSPredicate(format: "type == %@", type)
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let prices = data.value(forKey: "price") as? Int else {continue}
                price = prices
            }
        } catch {
            print("Failed")
        }
        return price
    }
    
    func addToCart(type: String, quantity: Int) {
        let container = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: container)
        let newItem = NSManagedObject(entity: entity!, insertInto: container)
        newItem.setValue(type, forKey: "type")
        newItem.setValue(quantity, forKey: "quantity")
        do {
            try container.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getCartItems() -> [CartItem] {
        var cartItem = [CartItem]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let type = data.value(forKey: "type") as? String,
                    let quantity = data.value(forKey: "quantity") as? Int
                    else {
                        continue
                }
                cartItem.append(CartItem(type: type, quantity: quantity))
            }
        } catch {
            print("Failed")
        }
        return cartItem
    }
    
    func getUser(uid: String) -> UserData {
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.predicate = NSPredicate(format: "uid == %@", uid)
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            guard
                let data = result[0] as? NSManagedObject,
                let userId = data.value(forKey: "uid") as? String,
                let name = data.value(forKey: "name") as? String,
                let email = data.value(forKey: "email") as? String,
                let phone = data.value(forKey: "phone") as? String,
                let address = data.value(forKey: "address") as? String
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
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
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: container)
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
        let parameters = ["phone"   : phone,
                          "address" : address]
        profile.child(uid).setValue(parameters)
    }
    
    func deleteUsers() {
        let container = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.execute(batchDeleteRequest)
            
        } catch {
            print("Failed")
        }
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
