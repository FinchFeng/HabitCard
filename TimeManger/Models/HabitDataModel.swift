//
//  HabitDataModel.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/29.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation
import UIKit

struct HabitData:Codable {//可储存 codeable
    
    //管理数据
    var name:String
    var dailyTime:Time
    var weekilyFrequency:Int
    var motive:String
    init(name:String,dailyTime:Time,weekilyFrequency:Int,color:UIColor,motive:String) {
        self.name = name
        self.dailyTime = dailyTime
        self.weekilyFrequency = weekilyFrequency
        //添加之后直接展示这个习惯
        self.todaysRemainTime = dailyTime
        self.thisWeekRemainFrequancy = weekilyFrequency
        self.colorInt = color.changeToAInt()
        self.motive = motive
    }
    
    //每日数据
    var todaysRemainTime = Time()//每日更新
    var thisWeekRemainFrequancy = 0//每周更新
    var todayNeedToDisplay = true//每日更新
    
    //记录数据
    var totalExecuteTime = Time()
    var totalExecuteDays = 0
    var totalJumpOverDays = 0

    //上周未完成
    var lastWeekHaventDoneTime = Time()//每周更新
    var lastWeekHaventDoneFrequancy = 0//每周更新
    
    //颜色
    var colorInt:Int
    
    //新旧数据转换
    init(oldData:OldHabitData){
        //全部的属性
        self.init(name: oldData.name, dailyTime: oldData.dailyTime, weekilyFrequency: oldData.weekilyFrequency, color: oldData.colorInt.changeToAColor(), motive: "")
        self.todaysRemainTime = oldData.todaysRemainTime
        self.thisWeekRemainFrequancy = oldData.thisWeekRemainFrequancy
        self.todayNeedToDisplay = oldData.todayNeedToDisplay
        self.totalExecuteTime = oldData.totalExecuteTime
        self.totalExecuteDays = oldData.totalExecuteDays
        self.totalJumpOverDays = oldData.totalJumpOverDays
        self.lastWeekHaventDoneTime = oldData.lastWeekHaventDoneTime
        self.lastWeekHaventDoneFrequancy = oldData.lastWeekHaventDoneFrequancy
    }
}


struct OldHabitData:Codable {
    //管理数据
    var name:String
    var dailyTime:Time
    var weekilyFrequency:Int
    //每日数据
    var todaysRemainTime = Time()//每日更新
    var thisWeekRemainFrequancy = 0//每周更新
    var todayNeedToDisplay = true//每日更新
    
    //记录数据
    var totalExecuteTime = Time()
    var totalExecuteDays = 0
    var totalJumpOverDays = 0
    
    //上周未完成
    var lastWeekHaventDoneTime = Time()//每周更新
    var lastWeekHaventDoneFrequancy = 0//每周更新
    //颜色
    var colorInt:Int
    
    init(name:String,dailyTime:Time,weekilyFrequency:Int,color:UIColor) {
        self.name = name
        self.dailyTime = dailyTime
        self.weekilyFrequency = weekilyFrequency
        //添加之后直接展示这个习惯
        self.todaysRemainTime = dailyTime
        self.thisWeekRemainFrequancy = weekilyFrequency
        self.colorInt = color.changeToAInt()
    }
   
}

