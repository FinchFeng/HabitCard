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
    
    private static var isTiming:Bool {
        get{
            return (UserDefaults.standard.object(forKey: "isTiming") as? Bool) ?? false
        }
        set{
            UserDefaults.standard.set(newValue,forKey:"isTiming")
        }
    }
    
    private static var passedTime:Time = Time()
    
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
    
    static func startTiming(changeInterFaceBlock:@escaping (Time)->Void){
        passedTime = Time()
        startTimePoint = Date()
        self.changeInterFaceBlock = changeInterFaceBlock
        startTimer()
    }
    
    static func checkNeedRestart(changeInterFaceBlock:@escaping (Time)->Void){
//        print("checkNeedRestart \(isTiming)")
//        print(startTimePoint)
        if isTiming {
            self.changeInterFaceBlock = changeInterFaceBlock
            startTimer()
        }
    }
    
   private static func startTimer(){//在后台被删除之后重新打开应用之后可以使用这个重新计时
        isTiming = true
        currentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            if let passedTime = BackgroundTimer.getPastTime() {
                print(isTiming)
                BackgroundTimer.passedTime = passedTime
                BackgroundTimer.changeInterFaceBlock!(passedTime)
            }
        }
    }
    
    static func stoptiming(){
        isTiming = false
        if changeInterFaceBlock == nil {return}
        changeInterFaceBlock!(Time())
        currentTimer?.invalidate()
        currentTimer = nil
    }
    
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

struct Time {
    
    var hour:Int = 0
    var min:Int = 0
    var second:Int = 0
}

