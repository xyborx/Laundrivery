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
    var type: [String] = [String]()
    let itemsPerRow: CGFloat = 1
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category)
    }

    override func viewDidLoad() {
        type = DatabaseService.shared.getTypes(category: category)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        typeTable.separatorStyle = UITableViewCellSeparatorStyle.none
        typeTable.separatorInset = UIEdgeInsets.zero
        typeTable.layoutMargins = UIEdgeInsets.zero
    }
}

extension CategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTable.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as! TypeTableViewCell
        cell.img.image = UIImage(named: "background")
        cell.label.text = type[indexPath.row]
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    
}
