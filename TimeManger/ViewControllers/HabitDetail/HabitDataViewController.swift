//
//  HabitDataViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class HabitDataViewController: UIViewController {
    
    var model:HabitModel!
    
    var tabBarVC:MainTabBarController {
        return self.tabBarController! as! MainTabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //在这里获取TabBarController的Model
        model = tabBarVC.model
    }
    
    //上周未完成数组
    
    //已经坚持数据
    
    //MARK:TableViews
    
    //使用一个TableView来展示
    //做两种Cell出来，一种标题，一种数据表现
    
    //配置点击之后的Segue数据
    
}


