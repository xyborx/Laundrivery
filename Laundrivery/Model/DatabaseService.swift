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
    
    let cart = Database.database().reference().child("cart")
    let history = Database.database().reference().child("history")
    let profile = Database.database().reference().child("profile")
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let localData = ["Cart", "History", "UserProfile"]
    
    private let categories = ["Tops", "Trousers", "Dresses", "Shoes", "Others"]
    
    private let laundryItems: [LaundryItem] = [LaundryItem(category: "Tops", type: "Shirt", price: 20000),
                                      LaundryItem(category: "Tops", type: "Batik", price: 25000),
                                      LaundryItem(category: "Tops", type: "Blouse", price: 20000),
                                      LaundryItem(category: "Tops", type: "T-Shirt", price: 20000),
                                      LaundryItem(category: "Tops", type: "Jacket", price: 20000),
                                      LaundryItem(category: "Tops", type: "Coat", price: 30000),
                                      LaundryItem(category: "Tops", type: "Sweater", price: 20000),
                                      LaundryItem(category: "Trousers", type: "Trouser", price: 25000),
                                      LaundryItem(category: "Trousers", type: "Jeans", price: 20000),
                                      LaundryItem(category: "Trousers", type: "Short", price: 20000),
                                      LaundryItem(category: "Dresses", type: "Dress", price: 15000),
                                      LaundryItem(category: "Dresses", type: "Skirt", price: 25000),
                                      LaundryItem(category: "Dresses", type: "Kebaya", price: 30000),
                                      LaundryItem(category: "Shoes", type: "Sneaker", price: 50000),
                                      LaundryItem(category: "Shoes", type: "Canvas", price: 60000),
                                      LaundryItem(category: "Shoes", type: "Suede", price: 60000),
                                      LaundryItem(category: "Shoes", type: "Leather", price: 70000),
                                      LaundryItem(category: "Shoes", type: "Hybrid", price: 80000),
                                      LaundryItem(category: "Others", type: "Bag of Clothes", price: 15000),
                                      LaundryItem(category: "Others", type: "Bed Sheet", price: 15000),
                                      LaundryItem(category: "Others", type: "Blanket", price: 20000),
                                      LaundryItem(category: "Others", type: "Bag", price: 30000)]
    
    private var userData: UserInfo?
    private var cartItems = [CartItem]()
    
    func initiate() {
        do {
            wipeOut()
            try Auth.auth().signOut()
        } catch {
            print("Failed sign out")
        }
    }
    
    func initiateLaunched() {
        self.cartItems = fetchCartLocally()
        if Auth.auth().currentUser != nil {
            self.userData = self.fetchUserLocal()
        }
    }
    
    /*
     LAUNDRY ITEM MANAGEMENT
    */
    
    func getLaundryItems() -> [LaundryItem] {
        return laundryItems
    }
    
    func getLaundryItems(category: String) -> [LaundryItem] {
        var data = [LaundryItem]()
        for item in laundryItems {
            if item.category == category {
                data.append(item)
            }
        }
        return data
    }
    
    func getLaundryItems(type: String) -> [LaundryItem] {
        var data = [LaundryItem]()
        for item in laundryItems {
            if item.type == type {
                data.append(item)
            }
        }
        return data
    }
    
    func getLaundryItem(named type: String) -> LaundryItem? {
        for item in laundryItems {
            if item.type == type {
                return item
            }
        }
        return nil
    }
    
    func getCategories() -> [String] {
        return categories
    }
    
    func getPrice(of type: String) -> Int? {
        if let item = self.getLaundryItem(named: type) {
            return item.price
        }
        return nil
    }
    
    /*
     CART MANAGEMENT
    */
    
    func addToCart(type: String, quantity: Int) {
        if cartItems.isEmpty {
            self.cartItems.append(CartItem(named: type, quantity: quantity))
        }
        else {
            for ind in 0..<cartItems.count {
                if cartItems[ind].detail.type == type {
                    cartItems[ind].quantity += quantity
                    break
                }
                else if ind == cartItems.count - 1 {
                    self.cartItems.append(CartItem(named: type, quantity: quantity))
                }
            }
        }
        saveCartLocally(cartItems: self.cartItems)
        if userData != nil {
            saveCartToCloud(cartItems: self.cartItems)
        }
    }
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func getCartItem(type: String) -> CartItem? {
        for item in cartItems {
            if item.detail.type == type {
                return item
            }
        }
        return nil
    }
    
    func fetchCartLocally() -> [CartItem] {
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
                cartItem.append(CartItem(named: type, quantity: quantity))
            }
        } catch {
            print("Failed")
        }
        return cartItem
    }
    
    func saveCartLocally(cartItems: [CartItem]) {
        deleteLocalData(named: "Cart")
        let container = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: container)
        for item in cartItems {
            let newItem = NSManagedObject(entity: entity!, insertInto: container)
            newItem.setValue(item.detail.type, forKey: "type")
            newItem.setValue(item.quantity, forKey: "quantity")
            do {
                try container.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    func saveCartToCloud(cartItems: [CartItem]) {
        for item in cartItems {
            let parameters = [item.detail.type: item.quantity]
            cart.child(self.userData!.userId).setValue(parameters)
        }
    }
    
    /*
     USER MANAGEMENT
     */
    
    func userSignIn(user: User) {
        let users = UserInfo(userId: user.uid, displayName: user.displayName!, email: user.email!)
        self.userData = fetchUserDetails(user: users)
        saveUserLocally()
    }
    
    func userSignUp() {
        if let user = fetchUserInfo() {
            self.userData = user
            saveUserLocally()
        }
    }
    
    func fetchUserInfo() -> UserInfo? {
        if let user = Auth.auth().currentUser {
            return UserInfo(userId: user.uid, displayName: user.displayName!, email: (user.email)!)
        }
        return nil
    }
    
    func fetchUserDetails(user: UserInfo) -> UserInfo {
        var detailedUser = user
        self.profile.child(user.userId).observeSingleEvent(of: .value, with: { (snapshot) in
            guard
                let snapDict = snapshot.value as? [String: Any],
                let phone = snapDict["phone"] as? String,
                let address = snapDict["address"] as? String
            else {return}
            detailedUser.phone = phone
            detailedUser.address = address
        })
        return detailedUser
    }
    
    func fetchUserLocal() -> UserInfo? {
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
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
                    return nil
            }
            return UserInfo(userId: userId, image: UIImage(), displayName: name, email: email, phone: phone, address: address)
        } catch {
            print("Failed")
        }
        return nil
    }
    
    func getUser() -> UserInfo? {
        return userData
    }
    
    func saveUserLocally() {
        if let user = self.userData {
            deleteLocalData(named: "UserProfile")
            let container = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "UserProfile", in: container)
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
    }
    
    func saveUserToCloud(user: UserInfo) {
        let parameters = ["phone"   : user.phone!,
                          "address" : user.address!]
        profile.child(user.userId).setValue(parameters)
    }
    
    /*
     DELETE DATA
     */
    
    func deleteLocalData(named: String) {
        let container = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: named)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.execute(batchDeleteRequest)
            
        } catch {
            print("Failed")
        }
    }
    
    func wipeOut() {
        for data in localData {
            deleteLocalData(named: data)
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
