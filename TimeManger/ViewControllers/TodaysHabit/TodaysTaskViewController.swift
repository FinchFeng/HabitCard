//
//  TodaysTaskViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class TodaysTaskViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var model:HabitModel!
    
    var tabBarVC:MainTabBarController {
        return self.tabBarController! as! MainTabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //在这里获取TabBarController的Model
        model = tabBarVC.model
        //配置CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        print("TodaysTask Loads")
        print(todaysHabbits)
//        print(model.habitArray)
    }
    //MARK: - CollectionViews 还有 移动顺序 和 储存颜色 的两个功能需要🔧
    @IBOutlet weak var collectionView: UICollectionView!
    
    //使用CollectionView展示今日习惯 有一个HabitData数组可以直接使用
    var todaysHabbits:[HabitData] {
        return model.habitForTodayArray
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysHabbits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id  = indexPath.row%2 == 0 ? "leftCard" : "rightCard"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as!  CardView
        //实例
        let data = todaysHabbits[indexPath.row]
        //在这里链接数据
        cell.setDatas(data:data, color: #colorLiteral(red: 0.1034872308, green: 0.3690240681, blue: 0.5518581867, alpha: 1))
        setCellMoreActionBlock(cell: cell)
        return cell
    }
    
    // MARK: - Collection View Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardWidth = Constants.screenWidth/2.07
        let cardHeight = cardWidth/Constants.cardsRadio
        //返回固定的Card大小
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    //配置习惯卡片被点击之后跳转到执行习惯的VC
    
    var selectedIndex = 0
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segueToExcuteHabitVC", sender: nil)
    }
    
    //配置习惯卡片的更多操作 ...按钮
    func setCellMoreActionBlock(cell:CardView){
        cell.setBlocks(todayDoneBlock: { (name) in
            self.model.todayDone(habitName: name)
            //刷新数据
            self.reloadDateFromModel()
            //完成奖励动画
            self.showAnimationDoneAHabit(name: name)
        }, jumpTodayBlock: { (name) in
            self.model.jumpOverSomeHabit(name: name)
            //刷新数据
            self.reloadDateFromModel()
        }) { (data) in
            //perform segue to 详细View
        }
    }
    //MARK: - 动画和重新从Model中刷新数据
    
    func reloadDateFromModel(){
        collectionView.reloadData()
    }
    
    func showAnimationDoneAHabit(name:String) {
        //动画
        let alertView = SPAlertView(title: "\(name) 已完成", message: nil, preset: .done)
        alertView.duration = 0.8//再调整🔧
        alertView.cornerRadius = 35
        alertView.present()
    }
    
    
    //MARK: - Segues and Segue back
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "segueToExcuteHabitVC"{
            let destiVC = segue.destination as! ExcuteHabitViewController
            let selectData = todaysHabbits[selectedIndex]
            destiVC.habitTitle = selectData.name
            destiVC.themeColor = #colorLiteral(red: 0.1034872308, green: 0.3690240681, blue: 0.5518581867, alpha: 1)
            destiVC.todayRemainTime = selectData.todaysRemainTime
        }
    }
    
    
    @IBAction func addNewHabit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueToAddNewHabitVC", sender: nil)
    }
    
    //跳转到另外一个VC来添加习惯 处理这个VC返回到数据
    
    @IBAction func segue() {
        performSegue(withIdentifier: "segueToAddNewHabitVC", sender: nil)
    }
    
    //Unwind Action
    @IBAction func unwind(segue:UIStoryboardSegue){
        print("back To Today")
    }
    

}
