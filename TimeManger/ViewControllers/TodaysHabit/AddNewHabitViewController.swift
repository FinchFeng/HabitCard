//
//  AddNewHabitViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
//收集新习惯数据并且Unwind给Model 对5s屏幕进行适配 🔧

import UIKit

class AddNewHabitViewController: UIViewController {

    @IBOutlet weak var newHabitTextField: UITextField!
    @IBOutlet weak var newHabitDailyTimeField: UITextField!
    @IBOutlet weak var newHabitWeeklyFrequencyField: UITextField!
    @IBOutlet weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.addCircle(frame: circleView.bounds, fillColor: UIColor.lightGray, strokeColor: UIColor.clear, lineWidth: 0)
    }
    
    @IBAction func doneAction() {
        print("Done")
    }
    
    @IBAction func cancelButton() {
        print("unwind with a new habit data")
    }
    
}
