//
//  MainTabBar.swift
//  kabreet
//
//  Created by Essam Orabi on 18/04/2023.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items?[0].title = "History".localized()
        self.tabBar.items?[1].title = "Vehicles".localized()
        self.tabBar.items?[2].title = "Setting".localized()
       // self.selectedIndex = 1
    }
}
