//
//  HomeVC.swift
//  Laundrivery
//
//  Created by Difa Sanditya Alifian on 03/12/17.
//  Copyright © 2017 Difa Sanditya Alifian. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {
    
    let category = ["Tops", "Laundry", "Suits", "Trousers", "Dresses"]

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
        //Tabs Space
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarLeftContentInset = 8
        settings.style.buttonBarRightContentInset = 8
        settings.style.buttonBarItemLeftRightMargin = 12
        //Tabs Full Width
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        //Tabs Font
        settings.style.buttonBarItemFont = UIFont(name: "Avenir Light", size: 14)!
        
        super.viewDidLoad()
        buttonBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: buttonBarView.frame.height)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var uiview = [UIViewController]()
        for cat in category {
            let uis = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "categorySB") as! CategoryVC
            uis.category = cat
            uiview.append(uis)
        }
        return uiview
    }
}
