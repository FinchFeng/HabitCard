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
    }
    //MARK:CollectionViews 还有 移动顺序 和 储存颜色 的两个功能需要🔧
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id  = indexPath.row%2 == 0 ? "leftCard" : "rightCard"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as!  CardView
        //实例
        cell.setDatas(title: "Work", todayRemain: Time(hour:3,min:45,second:0), weekilyRemainFrequancy: 3, color: #colorLiteral(red: 0.02745098039, green: 0.462745098, blue: 0.4705882353, alpha: 1) )
        //在这里链接数据
        return cell
    }
    
    // MARK: - Collection View Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardWidth = Constants.screenWidth/2.07
        let cardHeight = cardWidth/Constants.cardsRadio
        //返回固定的Card大小
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
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
