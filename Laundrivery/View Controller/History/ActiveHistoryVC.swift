//
//  ActiveHistoryVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 05/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ActiveHistoryVC: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Active")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let histories = DatabaseService.shared.getActiveHistories()
    
    override func viewDidLoad() {
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    
}

extension ActiveHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.button.setTitle("Order ID #\(histories[indexPath.row].date.timeIntervalSince1970)".replacingOccurrences(of: ".", with: ""), for: .normal)
        return cell
    }
}
