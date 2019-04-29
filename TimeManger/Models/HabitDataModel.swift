//
//  HabitDataModel.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/29.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation

class HabitData:Codable {//可储存 codeable
    
    //管理数据
    var name:String
    var weekilyTime:Time
    var weekilyFrequency:Int
    init(name:String,weekilyTime:Time,weekilyFrequency:Int) {
        self.name = name
        self.weekilyTime = weekilyTime
        self.weekilyFrequency = weekilyFrequency
    }
    
    //每日数据
    var todaysRemainTime = Time()
    var thisWeekRemainFrequancy = 0
    var todayNeedToDisplay = false
    
    //记录数据
    var totalExecuteTime = Time()
    var totalExecuteDays = 0
    var tatalJumpOverDays = 0
    
    //上周未完成
    var lastWeekHaventDoneTime = Time()
    var lastWeekHaventDoneFrequancy = 0
    
}


