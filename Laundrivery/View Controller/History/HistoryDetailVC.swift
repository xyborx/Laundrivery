//
//  HistoryDetailVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 11/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit

class HistoryDetailVC: UIViewController {
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var pickUpAddress: UILabel!
    @IBOutlet weak var deliveryAddress: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var orderIds = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
