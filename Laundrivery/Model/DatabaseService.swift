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
    private var histories = [HistoryInfo]()
    
    func initiate() {
        do {
            wipeOut()
            try Auth.auth().signOut()
        } catch {
            print("[Laundrivery Error]:[Failed in 'initiate()'")
        }
    }
    
    func initiateLaunched() {
        self.cartItems = fetchCartLocally()
        self.histories = fetchHistoryLocally()
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
    
    func updateCartItem() {
        var cartItems = [CartItem]()
        for cart in self.cartItems {
            if cart.quantity != 0 {
                cartItems.append(cart)
            }
        }
        self.cartItems = cartItems
        saveCartLocally(cartItems: self.cartItems)
    }
    
    func updateCartItem(type: String, quantity: Int) {
        for ind in 0..<cartItems.count {
            if cartItems[ind].detail.type == type {
                cartItems[ind].quantity = quantity
                updateCartItem()
                saveCartLocally(cartItems: self.cartItems)
                return
            }
        }
    }
    
    func deleteCartItem(type: String) {
        for ind in 0..<cartItems.count {
            if cartItems[ind].detail.type == type {
                cartItems.remove(at: ind)
                saveCartLocally(cartItems: self.cartItems)
                return
            }
        }
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
            print("[Laundrivery Error]:[Failed in 'fetchCartLocally()']")
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
                print("[Laundrivery Error]:[Failed in 'saveCartLocally(cartItems: [CartItem])']")
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
     HISTORY MANAGEMENT
     */
    
    func getHistories() -> [HistoryInfo] {
        return histories
    }
    
    func addHistory(cartItems: [CartItem], pickUpAddres: String, deliveryAddress: String) {
        let date = Date()
        let orderId = userData!.userId + "\(date.timeIntervalSince1970)".replacingOccurrences(of: ".", with: "")
        self.histories.append(HistoryInfo(date: date, orderId: orderId, order: cartItems, pickUpAddress: pickUpAddres, deliveryAddress: deliveryAddress, status: "Waiting for driver"))
        saveHistoryLocally(histories: self.histories)
        saveHistoryToCloud(histories: self.histories)
        self.cartItems.removeAll()
        deleteLocalData(named: "Cart")
    }
    
    func saveHistoryLocally(histories: [HistoryInfo]) {
        deleteLocalData(named: "History")
        let container = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "History", in: container)
        for history in histories {
            var order = ""
            for item in history.order {
                order += "\(item.detail.type).\(item.quantity)"
                if item.detail.type != cartItems.last?.detail.type {
                    order += ","
                }
            }
            let newItem = NSManagedObject(entity: entity!, insertInto: container)
            newItem.setValue(history.date, forKey: "date")
            newItem.setValue(history.deliveryAddress, forKey: "deliveryAddress")
            newItem.setValue(order, forKey: "order")
            newItem.setValue(history.orderId, forKey: "orderId")
            newItem.setValue(history.pickUpAddress, forKey: "pickUpAddress")
            newItem.setValue(history.status, forKey: "status")
            do {
                try container.save()
            } catch {
                print("[Laundrivery Error]:[Failed in 'saveHistory(cartItems: [CartItem])']")
            }
        }
    }
    
    func fetchHistoryLocally() -> [HistoryInfo] {
        var histories = [HistoryInfo]()
        let container = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        do {
            let result = try container.fetch(request)
            for data in result as! [NSManagedObject] {
                guard
                    let date = data.value(forKey: "date") as? Date,
                    let deliveryAddress = data.value(forKey: "deliveryAddress") as? String,
                    let order = data.value(forKey: "order") as? String,
                    let orderId = data.value(forKey: "orderId") as? String,
                    let pickUpAddress = data.value(forKey: "pickUpAddress") as? String,
                    let status = data.value(forKey: "status") as? String
                else {
                        continue
                }
                let orders = order.components(separatedBy: ",")
                var cartItems = [CartItem]()
                for order in orders {
                    let data = order.components(separatedBy: ".")
                    cartItems.append(CartItem(named: data[0], quantity: Int(data[1])!))
                }
                histories.append(HistoryInfo(date: date, orderId: orderId, order: cartItems, pickUpAddress: pickUpAddress, deliveryAddress: deliveryAddress, status: status))
            }
        } catch {
            print("[Laundrivery Error]:[Failed in 'fetchHistory()']")
        }
        return histories
    }
    
    func saveHistoryToCloud(histories: [HistoryInfo]) {
        for history in histories {
            let parameters = ["date": "\(history.date)", "deliveryAddress": history.deliveryAddress, "pickUpAdress": history.pickUpAddress, "status": history.status]
            self.history.child(userData!.userId).child(history.orderId).setValue(parameters)
            for item in history.order {
                let parameters = [item.detail.type: item.quantity]
                self.history.child(userData!.userId).child(history.orderId).child("orders").setValue(parameters)
            }
        }
    }
    
    /*
     USER MANAGEMENT
     */
    
    func userSignIn(user: User) {
        let users = UserInfo(userId: user.uid, displayName: user.displayName!, email: user.email!)
        self.userData = fetchUserDetails(user: users)
        self.saveUserLocally(user: self.userData)
    }
    
    func userSignUp() {
        if let user = fetchUserInfo() {
            self.userData = user
            self.saveUserLocally(user: self.userData)
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
                let email = data.value(forKey: "email") as? String
            else {
                return nil
            }
            guard
                let phone = data.value(forKey: "phone") as? String,
                let address = data.value(forKey: "address") as? String
            else {
                return UserInfo(userId: userId, displayName: name, email: email)
            }
            return UserInfo(userId: userId, displayName: name, email: email, phone: phone, address: address)
        } catch {
            print("[Laundrivery Error]:[Failed in 'fetchUserLocal()']")
        }
        return nil
    }
    
    func getUser() -> UserInfo? {
        return userData
    }
    
    func saveUserLocally(user: UserInfo?) {
        if let user = user {
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
                print("[Laundrivery Error]:[Failed in 'saveUserLocally()']")
            }
        }
    }
    
    func saveUserToCloud(user: UserInfo) {
        let parameters = ["phone"   : user.phone!,
                          "address" : user.address!]
        profile.child(user.userId).setValue(parameters)
    }
    
    func updateUser(name: String, phone: String, address: String) {
        var current = self.userData!
        current.displayName = name
        if phone != "" {
            current.phone = phone
        }
        if address != "" {
            current.address = address
        }
        self.userData = current
        self.saveUserLocally(user: self.userData)
        if phone != "" && address != "" {
            self.saveUserToCloud(user: self.userData!)
        }
        else if phone != "" {
            let parameters = ["phone"   : self.userData!.phone!]
            self.profile.child(self.userData!.userId).setValue(parameters)
        }
        else if address != "" {
            let parameters = ["address" : self.userData!.address!]
            self.profile.child(self.userData!.userId).setValue(parameters)
        }
    }
    
    func updateUserImage(image: UIImage) {
        if image != UIImage(named: "user") {
            self.userData!.image = image
        }
    }
    
    func updateEmail(email: String) {
        self.userData!.email = email
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
            print("[Laundrivery Error]:[Failed in 'deleteLocalData(named: String)']")
        }
    }
    
    func wipeOut() {
        self.cartItems.removeAll()
        self.histories.removeAll()
        self.userData = nil
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
