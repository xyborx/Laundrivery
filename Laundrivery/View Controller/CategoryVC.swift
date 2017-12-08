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
    var data: [TypeItem] = [TypeItem]()
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category)
    }

    override func viewDidLoad() {
        data = DatabaseService.shared.getAllData(with: category)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        typeTable.separatorInset = UIEdgeInsets.zero
        typeTable.layoutMargins = UIEdgeInsets.zero
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
        cell.price.text = "\(data[indexPath.row].getStringPrice()) per piece"
        cell.quantity.text = "\(0)"
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    
}
