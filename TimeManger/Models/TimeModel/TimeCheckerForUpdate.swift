//
//  TimeCheckerForUpdate.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/2.
//  Copyright © 2019 冯奕琦. All rights reserved.
// 
//开应用要做的第一件事情就是调用这个类 还有从后台返回前端的时候

import Foundation

class TimeChecker {
    
    private static let userDefault = UserDefaults.standard
    
    //储存上次登陆的下个更新时间
    static var currentNextWeekliyDate:Date {
        get{
            //注意初始化 检查是否为nil
            if let oldData = userDefault.object(forKey: "currentNextWeekliyDate") as? Date {
                return oldData
            }else{
                let firstWeekliyDate = getNextDate(daily: false)
                print("TimeChecker 第一次获取weekily\(firstWeekliyDate.description(with: .current))")
                userDefault.set(firstWeekliyDate, forKey: "currentNextWeekliyDate")
                return firstWeekliyDate
            }
        }
        set{
            userDefault.set(newValue, forKey: "currentNextWeekliyDate")
        }
    }
    static var currentNextDaliyDate:Date {
        get{
            //注意初始化 检查是否为nil
            if let oldData = userDefault.object(forKey: "currentNextDaliyDate") as? Date {
                return oldData
            }else{
                let firstDailyDate = getNextDate(daily: true)
                print("TimeChecker 第一次获取firstDailyDate\(firstDailyDate.description(with: .current))")
                userDefault.set(firstDailyDate, forKey: "currentNextDaliyDate")
                return firstDailyDate
            }
        }
        set{
            userDefault.set(newValue, forKey: "currentNextDaliyDate")
        }
    }
    //需要日刷新的时间 例如 2:00 AM
    static var dailyUpdateTime:Int{
        get{
            if let oldData = userDefault.object(forKey: "dailyUpdateTime") as? Int{
                return oldData
            }else{
                //初始化
                
                userDefault.set(2, forKey: "dailyUpdateTime")
                return 2
            }
        }
        set{
            userDefault.set(newValue, forKey: "dailyUpdateTime")
            //更新下一个日期
            currentNextDaliyDate = getNextDate(daily: true)
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
    
    //实现方法:检查这次登陆与上次登陆中的时间段是否跨过需要刷新的时间点,如果跨过就刷新 
    static func checkUpdate(){
        //获取最近的星期一
        let nextMonday = getNextDate(daily: false)
        //判断NextMonday是否更新 更新说明:要是更新了说明已经过了这个点
        if currentNextWeekliyDate != nextMonday {
            //更新
            currentNextWeekliyDate = nextMonday
            //执行block
            weekilyUpdateBlocks?()
        }
        //或者日常更新的时间
        let nextDailyTime = getNextDate(daily: true)
        //判断NextMonday是否更新 更新说明:要是更新了说明已经过了这个点
        if currentNextDaliyDate != nextDailyTime {
            //更新
            currentNextDaliyDate = nextDailyTime
            //执行block
            dailyUpdateBlocks?()
        }
//        print(nextMonday.description(with: .current))
//        print("nextDailyTime \(nextDailyTime.description(with: .current))")
        
    }
    
    private static func getNextDate(daily:Bool)->Date{
        let currentTimePoint = Date()
        if daily {
            return  Calendar.current.nextDate(after: currentTimePoint, matching: DateComponents(hour:dailyUpdateTime), matchingPolicy: .nextTime)!
        }else{
            return Calendar.current.nextDate(after: currentTimePoint, matching: DateComponents(weekday:2), matchingPolicy: .nextTime)!
        }
    }
}
