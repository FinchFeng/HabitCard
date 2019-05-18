//
//  BackGroundTimer.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/26.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation
import UIKit

class BackgroundTimer {
    
    
    static var isTiming:Bool {
        get{
            return (UserDefaults.standard.object(forKey: "isTiming") as? Bool) ?? false
        }
        set{
            UserDefaults.standard.set(newValue,forKey:"isTiming")
        }
    }
    
    static var isPausing:Bool {
        get{
            return (UserDefaults.standard.object(forKey: "isPausing") as? Bool) ?? false
        }
        set{
            UserDefaults.standard.set(newValue,forKey:"isPausing")
        }
    }
    
    static var passedTime:Time = Time()
    static var pausingTime:Time = Time()
    
    
    static func startTiming(changeInterFaceBlock:@escaping (Time)->Void){
//        endTiming()
        passedTime = Time()
        startTimePoint = Date()
        self.changeInterFaceBlock = changeInterFaceBlock
        startTimer()
    }
    
    static func checkNeedRestart(changeInterFaceBlock:@escaping (Time)->Void,changeLabelToIsPausing:()->Void){//在后台被删除之后重新打开应用之后可以使用这个重新开始计时
        self.changeInterFaceBlock = changeInterFaceBlock
        if isTiming {
            startTimer()
        }
        if isPausing {
            startPausingTime()
            //更改时间标签为暂停中
            changeLabelToIsPausing()
        }
    }
    
    //使用这个方法来进行计时时间的改变
    
    static func set(time:Time){//直接设置时间
        //直接更改开始时间点
        let newStartPoint = Date()-time.changeToSecond()
        startTimePoint = newStartPoint
    }
    
   @discardableResult  private static func changeTime(time:Time)->Bool{//添加或者减少时间
        //把Time改成second
        let second:TimeInterval = time.changeToSecond()
        return changeTime(second:second)
    }
    
    private static func changeTime(second:TimeInterval)->Bool{//没有在计时的时候返回false
        if let startPoint = startTimePoint{
            //更改开始时间点
            let newPoint = startPoint + second
            startTimePoint = newPoint
            return true
        }else{
            return false
        }
        
    }
    
    static func endTiming(){//计时结束方法
        isTiming = false
        if changeInterFaceBlock == nil {return}
        changeInterFaceBlock!(Time())
        currentTimer?.invalidate()
        currentTimer = nil
        //要是在暂停中同时结束暂停计时
        isPausing = false
        currentPausingTimer?.invalidate()
        currentPausingTimer = nil
    }
    
    static func pauseTimimg(){//暂停计时 开始记录暂停时间
        isTiming = false
        currentTimer?.invalidate()
        startPausingTimePoint = Date()
        startPausingTime()
    }
    
    
    
    static func restartTiming(){//暂停之后 调整时间点 重新开始
        startTimer()
        //结算暂停的时间
        isPausing = false
        currentPausingTimer?.invalidate()
        currentPausingTimer = nil
        //更改时间点
        changeTime(time: pausingTime)
        pausingTime = Time()
    }
    
    //MARK: Private funcation
    
    private static func startTimer(){
        isTiming = true
        currentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            if let passedTime = BackgroundTimer.getPastTime(pausingTime: false) {
                print("Timing")
                print(passedTime)
                BackgroundTimer.passedTime = passedTime
                BackgroundTimer.changeInterFaceBlock!(passedTime)
            }
        }
    }
    
    private static func startPausingTime(){//重新进入屏幕可能也有调用
        isPausing = true
        currentPausingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            if let passTime = BackgroundTimer.getPastTime(pausingTime: true){
                BackgroundTimer.pausingTime = passTime
//                print("Pausing \(isTiming)")
                print(BackgroundTimer.pausingTime)
            }else{
                print("no timer")
            }
        })
    }
    
    private static var startTimePoint:Date?{
        get{
            return UserDefaults.standard.object(forKey: "startTimePoint") as? Date
        }
        set{
            return UserDefaults.standard.set(newValue,forKey:"startTimePoint")
        }
    }
    
    private static var currentTimer:Timer?
    
    private static var startPausingTimePoint:Date?{
        get{
            return UserDefaults.standard.object(forKey: "startPausingTimePoint") as? Date
        }
        set{
            return UserDefaults.standard.set(newValue,forKey:"startPausingTimePoint")
        }
    }
    
    private static var currentPausingTimer:Timer?
    
    private static var changeInterFaceBlock:((Time)->Void)? = nil
    
    private static func getPastTime(pausingTime:Bool)->Time?{
        //选择是否是pausing time
        let timePoint = pausingTime ? startPausingTimePoint : startTimePoint
        if let startTime = timePoint {
            let timeDistance = Date().timeIntervalSince(startTime)
            let totalSecond = Int(timeDistance)
            let hour = totalSecond/3600
            let min = (totalSecond/60)%60
            let second = totalSecond%60
            return Time(hour: hour, min: min, second: second)
        }else{
            return nil
        }
    }
    
}

struct Time:Codable {
    
    var hour:Int = 0
    var min:Int = 0
    var second:Int = 0
    
    //加减
    static func +(leftTime:Time,rightTime:Time)->Time{
        var second = leftTime.second+rightTime.second
        var min = (leftTime.min+rightTime.min+second/60)
        second = second%60
        let hour = (leftTime.hour+rightTime.hour+min/60)
        min = min%60
        return Time(hour: hour, min: min, second: second)
    }
    
    static func -(leftTime:Time,rightTime:Time)->Time{
        var second = leftTime.second-rightTime.second
        var min = leftTime.min - rightTime.min
        if second < 0 {
            min -= 1
            second = 60+second
        }
        var hour = leftTime.hour - rightTime.hour
        if min < 0 {
            hour -= 1
            min = 60+min
        }
        return Time(hour: hour, min: min, second: second)
    }
    
    static func *(time:Time,int:Int)->Time{
        var result = Time()
        for _ in 1...int{
            result = result + time
        }
        return result
    }
    
    //比较
    static func >(leftTime:Time,rightTime:Time)->Bool{
        if leftTime.hour == rightTime.hour {
            if leftTime.min == rightTime.min {
                if leftTime.min == rightTime.min {
                    return true
                }else{
                    return leftTime.second > rightTime.second
                }
            }
            return leftTime.min > rightTime.min
        }
        return leftTime.hour > rightTime.hour
    }
    
    func changeToSecond() -> TimeInterval {
        return TimeInterval(self.hour*3600+self.min*60+self.second)
    }
    
    func changeToString() -> String {
        let hourString = hour == 0 ? "" : "\(hour)h"
        let minString = hour == 0 ? "\(min)m" : "\(min)"
        return hourString + minString
    }
    
}

