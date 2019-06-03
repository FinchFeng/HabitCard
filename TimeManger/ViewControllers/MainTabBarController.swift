//
//  MainTabBarController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var model = HabitModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].title = ConstantsWord.todaysTask
        self.tabBar.items![1].title = ConstantsWord.habitData
        self.tabBar.items![2].title = ConstantsWord.settting
    }
    

    
}
