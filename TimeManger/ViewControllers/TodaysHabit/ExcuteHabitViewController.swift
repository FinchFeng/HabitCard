//
//  ExcuteHabitViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
//执行暂停开始时移等等 生成一个Time（）返回给Model
//或者直接可以已完成这个任务🔧

import UIKit

class ExcuteHabitViewController: UIViewController {
    
    //在上一个VC调用
    func setDataIn(habit:HabitData) {
        //配置颜色
        
        //title
        habitTitle = habit.name
        //今日的remainTime
        self.todayRemainTime = habit.todaysRemainTime
    }
    
    //Segue过来的数据
    var themeColor:UIColor!
    var habitTitle:String!
    var todayRemainTime:Time!
    
    //IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var excuteTimeLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var pauseAndRestartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = habitTitle
        remainTimeLabel.text = todayRemainTime.changeToString()
        view.backgroundColor = themeColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //画圈圈
        circleView.addCircle(frame: circleView.bounds, fillColor:  UIColor.clear, strokeColor: UIColor.white, lineWidth: 5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //ButtonActions
    
    @IBAction func pushButton(sender:UIButton){
        print(sender.tag)
        //开始暂停和结束 BackGroundTimer🔧
    }


}
