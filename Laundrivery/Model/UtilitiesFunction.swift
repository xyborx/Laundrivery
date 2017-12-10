//
//  UtilFunc.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 10/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class UtilitiesFunction {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
    
    static func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    static func saveImage(image: UIImage, named: String) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(named)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func getStringPrice(_ price: Int) -> String {
        var stringPrice = String()
        let price = "\(price)"
        for char in price.reversed() {
            if stringPrice.count > 1 && stringPrice.replacingOccurrences(of: ".", with: "").count % 3 == 0 {
                stringPrice = "." + stringPrice
            }
            stringPrice = "\(char)" + stringPrice
        }
        return "Rp \(stringPrice)"
    }
}
