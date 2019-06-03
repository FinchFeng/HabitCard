//
//  TodaysTaskViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//  适配iPad横屏🔧

import UIKit

class TodaysTaskViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var model:HabitModel!
    
    var tabBarVC:MainTabBarController {
        return self.tabBarController! as! MainTabBarController
    }
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //配置语言
        self.navigationController?.tabBarItem.title = ConstantsWord.todaysTask
        self.navigationTitle.title = ConstantsWord.todaysTitle
        //在这里获取TabBarController的Model
        model = tabBarVC.model
        //配置checker
        TimeChecker.weekilyUpdateBlocks = {
            self.model.culcalterWeekilyData()
        }
        TimeChecker.dailyUpdateBlocks = {
            self.model.updateTodaysHabit()
        }
        //配置CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        //添加collectionView的padding
        let topSpace = CGFloat(0)
        let hSpace = Constants.screenWidth*0.09
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = topSpace
        layout.minimumInteritemSpacing = hSpace
        layout.sectionInset = UIEdgeInsets(top: topSpace, left: hSpace, bottom: 0, right:hSpace)
        collectionView.collectionViewLayout = layout
        //配置长点手势
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        //Print
        print("TodaysTask Loads")
        print(todaysHabbits)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //检查model是否需要更新
        TimeChecker.checkUpdate()
        self.navigationController!.isNavigationBarHidden = true
        reloadDataFromModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //检查是否需要跳转到执行界面
        if BackgroundTimer.isTiming || BackgroundTimer.isPausing{
            print("还在计时中")
            performSegue(withIdentifier: "segueToExcuteHabitVC", sender: true)
        }
    }
    //MARK:无习惯的展示View
    @IBOutlet weak var messageHabitView: UIView!
    @IBOutlet weak var messageHabitLabel: UILabel!
    @IBOutlet weak var addNewHabitButton: UIButton!
    
    //MARK: - CollectionViews
    @IBOutlet weak var collectionView: UICollectionView!
    var longPressGesture: UILongPressGestureRecognizer!
    //使用CollectionView展示今日习惯 有一个HabitData数组可以直接使用
    var todaysHabbits:[HabitData] {
        return model.habitForTodayArray
    }

    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysHabbits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("刷新item\(indexPath.row)")
        let id = "cardCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as!  CardView
        //实例
        let data = todaysHabbits[indexPath.row]
        //在这里链接数据
        cell.setDatas(data:data)
        setCellMoreActionBlock(cell: cell)
        return cell
    }
    
    
    //顺序移动
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let startName = todaysHabbits[sourceIndexPath.row].name
        let endName = todaysHabbits[destinationIndexPath.row].name
        print("\(startName) -> \(endName)")
        model.reorderHabit(startName: startName, endName: endName)
    }
    // MARK: - Collection View Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardWidth = Constants.cardsWidth
        let cardHeight = cardWidth/(Constants.cardsRadio-Constants.collectionCellPadding)
        //返回固定的Card大小
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    
    //配置习惯卡片被点击之后跳转到执行习惯的VC
    var lastSelectedIndex:Int{//使用这个跳转执行View
        get{
            return UserDefaults.standard.object(forKey: "lastSelectedIndex") as! Int
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "lastSelectedIndex")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastSelectedIndex = indexPath.row
        performSegue(withIdentifier: "segueToExcuteHabitVC", sender: nil)
    }
    
    //配置习惯卡片的更多操作 ...按钮
    func setCellMoreActionBlock(cell:CardView){
        cell.setBlocks(todayDoneBlock: { (name) in
           self.finishSomeWork(name: name)
        }, jumpTodayBlock: { (name) in
            self.model.jumpOverSomeHabit(name: name)
            //刷新数据
            self.reloadDataFromModel()
        }) { (data) in
            //perform segue to 详细View
            self.performSegue(withIdentifier: "segueFromTodayToDetail", sender: data)
        }
    }
    //MARK: - 动画和重新从Model中刷新数据
    
    func finishSomeWork(name:String) {
        self.model.todayDone(habitName: name)
        //刷新数据
        self.reloadDataFromModel()
        //完成奖励动画
        self.showAnimationDoneAHabit(name: name)
    }
    
    func reloadDataFromModel(){
        collectionView.reloadData()
        if model.habitArray.isEmpty {
            messageHabitLabel.text = ConstantsWord.message1
            addNewHabitButton.isEnabled = true
            messageHabitView.isHidden = false
        }else if todaysHabbits.isEmpty{
            messageHabitLabel.text = ConstantsWord.mesdage2
            addNewHabitButton.isEnabled = false
            messageHabitView.isHidden = false
        }else{
            messageHabitView.isHidden = true
        }
        //更改badge
        AppNotification.changeBadge(to: todaysHabbits.count)
    }
    
    func showAnimationDoneAHabit(name:String) {
        //动画
        let alertView = SPAlertView(title: "\(name) \(ConstantsWord.taskDone)", message: nil, preset: .done)
        alertView.duration = 1.5//再调整🔧
        alertView.cornerRadius = 35
        alertView.present()
    }
    
    
    //MARK: - Segues and Segue back
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "segueToExcuteHabitVC"{
            let destiVC = segue.destination as! ExcuteHabitViewController
            let selectData = todaysHabbits[lastSelectedIndex]
            destiVC.habitTitle = selectData.name
            destiVC.themeColor = selectData.colorInt.changeToAColor()
            destiVC.todayRemainTime = selectData.todaysRemainTime
            destiVC.motivation = selectData.motive
            //检查是否是segue去restartTimer的
            if let needToRestart = sender as? Bool,needToRestart == true{
                destiVC.needToRestart = needToRestart
            }
        }else if segue.identifier! == "segueToAddNewHabitVC"{
            let destiVC = segue.destination as! AddNewHabitViewController
            destiVC.checkNameBlock = model.checkNameOfNewHabit
        }else if segue.identifier! == "segueFromTodayToDetail"{
            let data = sender as! HabitData
            let destiVC = segue.destination as! HabitDetailViewController
            destiVC.habitData = data
            destiVC.checkNameBlock = model.checkNameOfNewHabit
        }
    }
    
    
    @IBAction func addNewHabit() {
        performSegue(withIdentifier: "segueToAddNewHabitVC", sender: nil)
    }
    
    //跳转到另外一个VC来添加习惯 处理这个VC返回到数据
    
    @IBAction func segue() {
        performSegue(withIdentifier: "segueToAddNewHabitVC", sender: nil)
    }
    
    //这里储存是否需要从HabitDetail中返回
    var needToPopHabitDetailVC:Bool?
    //这里储存执行数据
    var excuteHabitName:String!
    var excuteTimeFromUnwind:Time?
    var unwindToFinishThisWork:Bool?
    //Unwind Action
    @IBAction func unwind(segue:UIStoryboardSegue){
        if let bool =  needToPopHabitDetailVC ,bool == true{
            let tabBarVC = tabBarController as! MainTabBarController
            tabBarVC.tabBar.isHidden = false
            if let navigationVC =  tabBarVC.viewControllers?[1] as? UINavigationController{
             navigationVC.popViewController(animated: false)
            }
        }
        if let time = excuteTimeFromUnwind {
            print(time)
            if model.excuteHabit(name: excuteHabitName, time: time){
                //刷新数据
                self.reloadDataFromModel()
                //完成奖励动画
                self.showAnimationDoneAHabit(name: excuteHabitName)
            }
        }
        if let bool = unwindToFinishThisWork{
            if bool == true {
                self.finishSomeWork(name: excuteHabitName)
            }
        }
        reloadDataFromModel()
        //清除数据
        excuteHabitName = nil
        unwindToFinishThisWork = nil
        excuteTimeFromUnwind = nil
        print("back To Today")
    }
    

}
