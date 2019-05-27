//
//  Constants.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/6.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static var screenWidth = UIScreen.main.bounds.width
    static var screenHeight = UIScreen.main.bounds.height
    // Cards
    static var cardsWidth: CGFloat = (screenWidth / 2) * 0.718
    static var collectionCellPadding: CGFloat = 0.07
    static var cardsRadio: CGFloat = 0.718
    static var cardsDistance: CGFloat = 0.13
}

class ConstantsWord {
    // 语言
    static var isLanguageChinese: Bool {
        return Locale.preferredLanguages[0].hasPrefix("zh")
    }

    static var todaysTask = isLanguageChinese ? "今日" : "Today"
    static var habitData = isLanguageChinese ? "统计" : "Habit"
    static var settting = isLanguageChinese ? "设置" : "Setting"
    static var todaysTitle = isLanguageChinese ? "今日计划" : "Today's Plan"
    static var habitDataTitle = isLanguageChinese ? "习惯统计" : "Habit's Data"
    // cards 🔧
    static var todayRemain = isLanguageChinese ? "今天" : "Today"
    static var thisWeek = isLanguageChinese ? "本周" : "Week"
    // 上周未完成和已经坚持
    static var lastweek = isLanguageChinese ? "上周未完成" : "Not completed last week"
    static var allHabit = isLanguageChinese ? "已经坚持" : "Has insisted"
    static var days = isLanguageChinese ? "天" : "Days"
    
    //setting
    static var contantUs = isLanguageChinese ? "联系我们" : "Contact us"
    static var updateTime = isLanguageChinese ? "今日计划更新时间" : "Today's plan update time "
    static var send = isLanguageChinese ? "发送" : "Send"
    static var suggestPlaceholder = isLanguageChinese ? "请输入您的建议" : "Please enter your suggestion"
    static var chosenUpdateTimePoint = isLanguageChinese ? "选择每天更新时间点" : "Choose a time point for daily updates"
    // 二级页面
    static var todaysTime = isLanguageChinese ? "今日剩余" : "Remaining today"
    
    static var totalDone = isLanguageChinese ? "总执行时间" : "Total execution time"
    static var totalJump = isLanguageChinese ? "跳过次数" : "Skip times"
    static var totalDays = isLanguageChinese ? "坚持天数" : "Persistence days"
    
    static var myNewHabitName = isLanguageChinese ? "我的新习惯是" : "My new habit is"
    static var myNewHabitTime1 = isLanguageChinese ? "我想每次在上面投入" : "I want to spend"
    static var myNewHabitTime2 = isLanguageChinese ? "时间" : "time"
    static var myNewHabitFrequency1 = isLanguageChinese ? "我想每周执行" : "I want to perform weekly"
    static var myNewHabitFrequency2 = isLanguageChinese ? "次" : "times"
    static var done = isLanguageChinese ? "确定" : "Done"
    
    //AlertSheet
    static var jumpToday = isLanguageChinese ? "今天跳过此习惯" : "Skip this habit today"
    static var todayDone = isLanguageChinese ? "已完成此习惯" : "This habit has been completed"
    static var lookDetail = isLanguageChinese ? "查看或编辑此习惯" : "View or edit this habit"
    static var taskDone = isLanguageChinese ? "已完成" : "Completed"
    static var card = isLanguageChinese ? "卡" : " Card"
    static var cancel = isLanguageChinese ? "取消" : "Cancel"
    static var editHabit = isLanguageChinese ? "编辑此习惯" : "Edit this habit"
    static var deleteHabit = isLanguageChinese ? "删除此习惯" : "Delete this habit"
    
    static var message1 = isLanguageChinese ? "点击这里添加您的第一个习惯" : "Click here to add your first habit"
    static var mesdage2 = isLanguageChinese ? "Yeah!今天的任务都完成了" : "Yeah! Today's mission is complete."
    static var checkMessage1 = isLanguageChinese ? "此名字被使用过了" : "This name has been used"
    static var checkMessage2 = isLanguageChinese ? "没有输入名称" : "No name entered"
    static var checkMessage3 = isLanguageChinese ? "每周次数不能超过7" : "The number of times per week cannot exceed 7"
    static var editTime = isLanguageChinese ? "编辑执行时间" : "Edit execution time"
    static var choseNewTime = isLanguageChinese ? "选择新的时间" : "Choose a new time"
    //对话框
    static var choseTimeLong = isLanguageChinese ? "选择时间长度" : "Select length of time"
    static var complete = isLanguageChinese ? "完成" : "Complete"
    static var attention = isLanguageChinese ? "注意" : "attention"
    static var good = isLanguageChinese ? "好的" : "OK"
    
    static var backMessage = isLanguageChinese ? "返回之后当前执行时间将作废" : "The current execution time will be invalid after returning"
    static var backButton = isLanguageChinese ? "返回(下次不再提醒)" : "Return (no more reminder next time)"
    static var stopping = isLanguageChinese ? "暂停中" : "Stopping"
}

struct ConstantsColor {
    private static var currentUsingColorInt: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "currentUsingColorInt")
        }
        get {
            if let oldData = UserDefaults.standard.object(forKey: "currentUsingColorInt") as? Int {
                return oldData
            } else {
                UserDefaults.standard.set(0, forKey: "currentUsingColorInt")
                return 0
            }
        }
    }

    static var colorsArray = [#colorLiteral(red: 0.1034872308, green: 0.3690240681, blue: 0.5518581867, alpha: 1), #colorLiteral(red: 0, green: 0.5352982283, blue: 0.6814761162, alpha: 1), #colorLiteral(red: 0.6589001417, green: 0.775041759, blue: 0.8751162291, alpha: 1), #colorLiteral(red: 0.5701642632, green: 0.7740980983, blue: 0.7254878879, alpha: 1), #colorLiteral(red: 0.3484483361, green: 0.623762846, blue: 0.8358900547, alpha: 1), #colorLiteral(red: 0.4552027583, green: 0.6703909039, blue: 0.7212151289, alpha: 1)]
    // 获取新的Color
    static func getAColor() -> UIColor {
        let currentOldColorInt = currentUsingColorInt
        print("颜色Int\(currentOldColorInt)")
        let newColorInt = (currentOldColorInt == colorsArray.count - 1 ? 0 : currentOldColorInt + 1)
        currentUsingColorInt = newColorInt
        return newColorInt.changeToAColor()
    }
}

extension Int {
    func changeToAColor() -> UIColor {
        return ConstantsColor.colorsArray[self]
    }
}

extension UIColor {
    func changeToAInt() -> Int! {
        for (index, color) in ConstantsColor.colorsArray.enumerated() {
            if color == self {
                return index
            }
        }
        print("系统没有这个颜色")
        return nil
    }
}

