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
    
    static var passedTime:Time = Time()
    
    
    static func startTiming(changeInterFaceBlock:@escaping (Time)->Void){
        passedTime = Time()
        startTimePoint = Date()
        self.changeInterFaceBlock = changeInterFaceBlock
        startTimer()
    }
    
    static func checkNeedRestart(changeInterFaceBlock:@escaping (Time)->Void){//在后台被删除之后重新打开应用之后可以使用这个重新开始计时
        if isTiming {
            self.changeInterFaceBlock = changeInterFaceBlock
            startTimer()
        }
    }
    
    //使用这个方法来进行计时时间的改变🔧
    static func changeTime(){
        
    }
    
    static func stoptiming(){//计时结束方法
        isTiming = false
        if changeInterFaceBlock == nil {return}
        changeInterFaceBlock!(Time())
        currentTimer?.invalidate()
        currentTimer = nil
    }
    
    static func pasueTimimg(){//暂停计时
        
    }
    
    static func restartTiming(){//暂停之后重新开始
        
    }
    
    //MARK: Private funcation
    
    private static func startTimer(){
        isTiming = true
        currentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            if let passedTime = BackgroundTimer.getPastTime() {
                print(isTiming)
                BackgroundTimer.passedTime = passedTime
                BackgroundTimer.changeInterFaceBlock!(passedTime)
            }
        }
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
    
    private static var changeInterFaceBlock:((Time)->Void)? = nil
    
    private static func getPastTime()->Time?{
        if let startTime = startTimePoint {
            let timeDistance = Date().timeIntervalSince(startTime)
//            print("Time distance \(timeDistance)")
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
    
}

