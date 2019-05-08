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
        //delegate设置
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
    }
    
    //上周未完成数组
    
    //已经坚持数据
    
    //MARK:TableViews
    @IBOutlet weak var tableView: UITableView!
    
    //Test shit
    @IBAction func test(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "segueToHabitDetailVC", sender: nil)
    }
    
    
}
extension HabitDataViewController:UITableViewDataSource,UITableViewDelegate{
    //使用一个TableView来展示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //检查是否有上周未完成数组
        
        //两个不同的cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitDataTableViewCell") as! HabitDataTableViewCell
            return cell
        }
    }
    
    
    //配置点击之后的Segue数据
    
}


