//
//  TimeMangerTests.swift
//  TimeMangerTests
//
//  Created by 冯奕琦 on 2019/4/24.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import XCTest
@testable import TimeManger

class TimeMangerTests: XCTestCase {
    //可以在这里直接对Model进行测试
    var model = HabitModel()
    
    override func setUp() {
    }
    
    func printAllhabit(){
        model.habitArray.forEach { (habit) in
            let data = try! JSONEncoder().encode(habit)
            let string = String(data: data, encoding: .utf8)
            print(string!)
        }
    }
    
    

    func testExample() {
//        model.addHabit(HabitData(name: "work", dailyTime: Time(hour: 2, min: 20, second: 0), weekilyFrequency: 3))
        printAllhabit()
    }

    func testDailyUpdate(){
        model.updateTodaysHabit()
        printAllhabit()
    }
    
    
}
//       print(model.excuteHabit(name: "fucking", time: Time(hour:1,min:33,second:12)))
//        model.updateTodaysHabit()
//        print(model.jumpOverSomeHabit(name: "working"))
//        model.jumpOverSomeHabit(name:"work")
//        model.excuteHabit(name: "read", time: Time(hour:0,min:30,second:0))
//        model.addHabit(HabitData(name: "work", dailyTime: Time(hour:3,min:30,second:0), weekilyFrequency: 4))
//        model.addHabit(HabitData(name: "read", dailyTime: Time(hour:1,min:0,second:0), weekilyFrequency: 3))
//        model.culcalterWeekilyData()
