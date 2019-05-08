//
//  ViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/24.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var model:HabitModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //重新进入应用
        
        model = HabitModel()
        BackgroundTimer.checkNeedRestart{ (time) in
            self.timeLabel.text = "\(time.hour):\(time.min):\(time.second)"
        }
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func clocking(){
        SPAlert.present(title: "已完成工作", preset: .done)
//        TimeChecker.checkUpdate()
//        BackgroundTimer.startTiming { (time) in
//            self.timeLabel.text = "\(time.hour):\(time.min):\(time.second)"
//        }
//
        
    }
    
    @IBAction func startAgain(){
        BackgroundTimer.restartTiming()

    }

    @IBAction func stopIt(_ sender: UIButton) {
       
        BackgroundTimer.pauseTimimg()
    }
    
    @IBAction func end(){
        BackgroundTimer.endTiming()
    }
    
    @IBAction func changeTime(){
      
        print("ChangeTime")
       print(BackgroundTimer.set(time: Time(hour:0,min:5,second:0)))
    }
    
}

