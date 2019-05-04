//
//  TimeCheckerForUpdate.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/2.
//  Copyright © 2019 冯奕琦. All rights reserved.
// 🔧

import Foundation

class TimeChecker {//开应用要做的第一件事情就是调用这个类 还有从后台返回前端的时候
    
    private static let userDefault = UserDefaults.standard
    
    //储存上次登陆的下个更新时间
    static var currentNextWeekliyDate:Date {//注意初始化⚠️
        get{
            return userDefault.object(forKey: "currentNextWeekliyDate") as! Date
        }
        set{
            userDefault.set(newValue, forKey: "currentNextWeekliyDate")
        }
    }
    static var currentNextDaliyDate:Date {//注意初始化⚠️
        get{
            return userDefault.object(forKey: "currentNextDaliyDate") as! Date
        }
        set{
            userDefault.set(newValue, forKey: "currentNextDaliyDate")
        }
    }
    //需要日刷新的时间 例如 2:00 AM
    static var dailyUpdateTime:Int{
        get{
            return userDefault.object(forKey: "dailyUpdateTime") as! Int
        }
        set{
            userDefault.set(newValue, forKey: "dailyUpdateTime")
        }
    }
    //需要周刷新的时间 例如 周一
    static var weeklyUpdateDay:Int{
        get{
            return userDefault.object(forKey: "weeklyUpdateDay") as! Int
        }
        set{
            userDefault.set(newValue, forKey: "weeklyUpdateDay")
        }
    }
    
    //更新的时候要进行的操作 ⚠️尽量早的配置它
    static var weekilyUpdateBlocks:(()->Void)?
    static var dailyUpdateBlocks:(()->Void)?
    
    
    
    //实现方法:检查这次登陆与上次登陆中的时间段是否跨过需要刷新的时间点,如果跨过就刷新 🔍
    static func checkUpdate(){
        let currentTimePoint = Date()
//        print(currentTimePoint.description(with: .current))
        //获取最近的星期一
        let nextMonday = Calendar.current.nextDate(after: currentTimePoint, matching: DateComponents(weekday:2), matchingPolicy: .nextTime)!
        //判断NextMonday是否更新 更新说明:要是更新了说明已经过了这个点
        if currentNextWeekliyDate != nextMonday {
            //更新
            currentNextWeekliyDate = nextMonday
            //执行block
            weekilyUpdateBlocks?()
        }
        //或者日常更新的时间
        let nextDailyTime = Calendar.current.nextDate(after: currentTimePoint, matching: DateComponents(hour:2), matchingPolicy: .nextTime)!
        //判断NextMonday是否更新 更新说明:要是更新了说明已经过了这个点
        if currentNextDaliyDate != nextDailyTime {
            //更新
            currentNextDaliyDate = nextDailyTime
            //执行block
            dailyUpdateBlocks?()
        }
        print(nextMonday.description(with: .current))
        print("nextDailyTime \(nextDailyTime.description(with: .current))")
        
    }
}
