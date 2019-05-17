//
//  HabitDataViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//  等待上周未完成的测试🔍 

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
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //每次展示这个VC的时候重新刷新数据
        tableView.reloadData()
    }
    
    
    //上周未完成数组
    
    var lastWeekHaventDoneArray:[HabitData]{
        return model.habitArray.filter({ (data) -> Bool in
            return data.lastWeekHaventDoneFrequancy > 0
        })
    }
    //已经坚持数据
    var haveExecuteHabitArray:[HabitData]{
        return model.habitArray.filter({ (data) -> Bool in
            return data.totalExecuteDays > 0
        })
    }
    
    //MARK:TableViews
    @IBOutlet weak var tableView: UITableView!
    
    //Test shit
    @IBAction func test(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueToHabitDetailVC", sender: nil)
    }
    
    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier , id == "segueToHabitDetailVC"{
            if let data = sender! as? HabitData{
                let destVC = segue.destination as! HabitDetailViewController
                destVC.habitData = data
                destVC.checkNameBlock = model.checkNameOfNewHabit
            }
        }
    }
    
    @IBAction func unwindBackToHabitData(sender:UIStoryboardSegue){
        print("back to habitData")
        tableView.reloadData()
    }
    
    
}
extension HabitDataViewController:UITableViewDataSource,UITableViewDelegate{
    //使用一个TableView来展示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalRow = 1
        if lastWeekHaventDoneArray.count > 0 {
            totalRow += 1 + lastWeekHaventDoneArray.count
        }
        totalRow += haveExecuteHabitArray.count
        return totalRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell's返回函数
        func getATitleCell()->TitleTableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            return cell
        }
        
        func getACell()->HabitDataTableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitDataTableViewCell") as! HabitDataTableViewCell
            return cell
        }
        
        let row = indexPath.row
        //检查是否有上周未完成数组
        if lastWeekHaventDoneArray.count > 0 {
            //生成未完成的cell
            if row == 0 {
                let cell = getATitleCell()
                cell.set(title: "上周未完成")
                return cell
            }else if row <= lastWeekHaventDoneArray.count+1{
                //生成未完成
                let index = row-1
                let cell = getACell()
                cell.setDataIn(data: lastWeekHaventDoneArray[index], isHaventDoneCell: true)
                return cell
            }else if row == lastWeekHaventDoneArray.count+2{
                let cell = getATitleCell()
                cell.set(title: "已经坚持")
                return cell
            }else{
                //生成未完成
                let index = row-lastWeekHaventDoneArray.count-2
                let cell = getACell()
                cell.setDataIn(data: haveExecuteHabitArray[index], isHaventDoneCell: false)
                return cell
            }
        }else{
            //只要生成普通的就好
            if row == 0{
                let cell = getATitleCell()
                cell.set(title: "已经坚持")
                return cell
            }else{
                //生成未完成
                let index = row-1
                let cell = getACell()
                cell.setDataIn(data: haveExecuteHabitArray[index], isHaventDoneCell: false)
                return cell
            }
        }
    }
    
    
    //配置点击之后的Segue数据
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HabitDataTableViewCell
        performSegue(withIdentifier: "segueToHabitDetailVC", sender: cell.data)
    }
    
}


