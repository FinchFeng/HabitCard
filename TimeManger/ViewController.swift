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
//        BackgroundTimer.checkNeedRestart{ (time) in
//            self.timeLabel.text = "\(time.hour):\(time.min):\(time.second)"
//        }
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func clocking(){
//        print(model.habitArray)
//        BackgroundTimer.startTiming { (time) in
//            self.timeLabel.text = "\(time.hour):\(time.min):\(time.second)"
//        }
    }

    @IBAction func stopIt(_ sender: UIButton) {
//        let newHabitArray = HabitData(name: "fuck", weekilyTime: Time(hour:2,min:49,second:2), weekilyFrequency: 5)
//        model.habitArray = []
//        BackgroundTimer.stoptiming()
    }
}

