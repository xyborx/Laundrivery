//
//  HistoryVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import Firebase
import XLPagerTabStrip

class HistoryVC: ButtonBarPagerTabStripViewController {
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var sorryView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            self.navigationController?.isNavigationBarHidden = true
            historyView.isHidden = true
            sorryView.isHidden = false
        }
        else {
//            self.navigationController?.navigationBar.shadowImage = UIImage()
            historyView.isHidden = false
            sorryView.isHidden = true
        }
    }

    override func viewDidLoad() {
        //Tabs Settings
        //Tabs Background
        settings.style.buttonBarBackgroundColor = UIColor(red: 52.0/255.0, green: 63.0/255.0, blue: 75.0/255.0, alpha: 1)
        //Tabs Button Background
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 52.0/255.0, green: 63.0/255.0, blue: 75.0/255.0, alpha: 1)
        //Selected Bar Color
        settings.style.selectedBarBackgroundColor = .white
        //Selected Bar height
        settings.style.selectedBarHeight = 1.2
        
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
//
//        buttonBarView.layer.borderWidth = 1.0
//        buttonBarView.layer.borderColor = UIColor.white.cgColor
        
        super.viewDidLoad()
        buttonBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: buttonBarView.frame.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            self.navigationController?.isNavigationBarHidden = false
        }
//        self.navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let active = UIStoryboard(name: "ActiveHistory", bundle: nil).instantiateViewController(withIdentifier: "activeHistory")
        let past = UIStoryboard(name: "PastHistory", bundle: nil).instantiateViewController(withIdentifier: "pastHistory")
        return [active, past]
    }
}
