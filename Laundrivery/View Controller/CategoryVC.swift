//
//  CategoryVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 06/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CategoryVC: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var typeTable: UITableView!
    
    var category = ""
    var data: [LaundryItem] = [LaundryItem]()
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category)
    }

    override func viewDidLoad() {
        data = DatabaseService.shared.getLaundryItems(category: category)
        typeTable.separatorInset = UIEdgeInsets.zero
        typeTable.layoutMargins = UIEdgeInsets.zero
        super.viewDidLoad()
    }
}

extension CategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTable.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as! TypeTableViewCell
        cell.img.image = UIImage(named: data[indexPath.row].type)
        cell.type.text = data[indexPath.row].type
        cell.price.text = "\(UtilitiesFunction.getStringPrice(data[indexPath.row].price)) per piece"
        cell.quantity.text = "\(0)"
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    
}
