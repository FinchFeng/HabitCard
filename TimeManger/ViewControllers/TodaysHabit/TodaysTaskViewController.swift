//
//  TodaysTaskViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class TodaysTaskViewController: UIViewController {
    
    var model:HabitModel!
    
    var tabBarVC:MainTabBarController {
        return self.tabBarController! as! MainTabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //在这里获取TabBarController的Model
        model = tabBarVC.model
        
        print("TodaysTask Loads")
    }
    //MARK:CollectionViews
    
    //使用CollectionView展示今日习惯 有一个HabitData数组可以直接使用
    var todaysHabbits:[HabitData] {
        return model.habitForTodayArray
    }
    
    //配置习惯卡片被点击之后跳转到执行习惯的VC 处理执行习惯VC返回之后的数据
    
    //配置习惯卡片的更多操作 ...按钮
    
    
    //MARK:Segues and Segue back

    //跳转到另外一个VC来添加习惯 处理这个VC返回到数据
    
    @IBAction func segue() {
        performSegue(withIdentifier: "segueToAddNewHabitVC", sender: nil)
    }
    

}
