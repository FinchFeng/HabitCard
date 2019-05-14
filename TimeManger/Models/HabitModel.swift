//
//  HabitModel.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/29.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation

class HabitModel {
    
    init() {
        //获取数据
        habitArray = getHabitDataFromDocument()
    }
    //检查名称是否可以使用
    func checkNameOfNewHabit(name:String)->Bool{
        for habit in habitArray {
            if habit.name == name {
                return false
            }
        }
        return true
    }
    //总习惯数组(直接储存和获取)
    var habitArray:[HabitData] = []{
        didSet{
//            print("setHabitArray")
            setHabitDataToDocument(habitArray)
        }
    }
    
    //MARK:总习惯更改代码
    //修改某一个习惯
    func changeHabit(oldName:String ,newHabit:HabitData){
        for (index,existHabit) in habitArray.enumerated(){
            if existHabit.name == oldName {
                //只有这三个变量可以修改
                habitArray[index].name = newHabit.name
                habitArray[index].dailyTime = newHabit.dailyTime
                habitArray[index].weekilyFrequency = newHabit.weekilyFrequency
                //检查这周或者今天需要执行的数据是否需要更改
                if habitArray[index].todaysRemainTime > newHabit.dailyTime{
                    habitArray[index].todaysRemainTime = newHabit.dailyTime
                }
                if habitArray[index].thisWeekRemainFrequancy > newHabit.weekilyFrequency{
                    habitArray[index].thisWeekRemainFrequancy = newHabit.weekilyFrequency
                }
                return
            }
        }
    }
    //添加一个习惯
    @discardableResult func addHabit(_ habit:HabitData)->Bool{
        //检查是否有同名
        for existHabit in habitArray{
            if existHabit.name == habit.name {
                return false
            }
        }
        habitArray.append(habit)
        return true
    }
    //更改卡片的顺序 🔧跟UICollectionView的方法结合
    //删除一个习惯
    func deleteHabit(name:String){
        for (index,habit) in habitArray.enumerated(){
            if habit.name == name {
                habitArray.remove(at: index)
                return
            }
        }
    }
    //MARK:今日习惯代码
    //获取今日习惯数组 应该是一个计算属性
    var habitForTodayArray:[HabitData]{
        return habitArray.filter({ (habit) -> Bool in
            return habit.todayNeedToDisplay
        })
    }
    //今日习惯刷新代码 写入数据  
    func updateTodaysHabit(){//在用户某一次超过设定的时间点之后进入应用之后调用
        for index in 0..<habitArray.count {
            if habitArray[index].todayNeedToDisplay {
                //记录未完成的时间和次数加入 并且不减少次数
//                habitArray[index].thisWeekRemainFrequancy -= 1
                jumpOverSomeHabit(name:habitArray[index].name)
            }
            //更改todayNeedToDisplay
            if habitArray[index].thisWeekRemainFrequancy > 0 {
                habitArray[index].todayNeedToDisplay = true
                habitArray[index].todaysRemainTime = habitArray[index].dailyTime
            }
        }
    }
    
    //增加时间（要是时间超过直接完成）
    func excuteHabit(name:String,time:Time) -> Bool {
        for index in 0..<habitArray.count{
            if habitArray[index].name == name {
                let zeroTime = Time()
                let remainTime = habitArray[index].todaysRemainTime - time
                //记录使用时间
                habitArray[index].totalExecuteTime = time + habitArray[index].totalExecuteTime
                if remainTime > zeroTime {
                    habitArray[index].todaysRemainTime = remainTime

                    return false
                }else{
                    //完成
                    habitArray[index].todaysRemainTime = zeroTime
                    todayDone(habitName: name)
                    return true
                }
            }
        }
        return false
    }
    //跳过某个习惯
    func jumpOverSomeHabit(name:String){
        for index in 0..<habitArray.count{
            if habitArray[index].name == name {
                habitArray[index].todayNeedToDisplay = false
                return
            }
        }
    }
    //直接完成
    func todayDone(habitName:String) {
        for index in 0..<habitArray.count{
            if habitArray[index].name == habitName {
                habitArray[index].todayNeedToDisplay = false
                habitArray[index].thisWeekRemainFrequancy -= 1
                assert(habitArray[index].thisWeekRemainFrequancy >= 0)
                //记录已完成数据
                habitArray[index].totalExecuteDays += 1
                habitArray[index].totalExecuteTime = habitArray[index].todaysRemainTime + habitArray[index].totalExecuteTime
                return
            }
        }
    }
    //MARK:获取习惯统计数据
    
    //每周清零一次
    func culcalterWeekilyData(){
        for index in 0..<habitArray.count{
            //进行时间统计
            let remianFrequancy = habitArray[index].thisWeekRemainFrequancy
            if remianFrequancy > 0 {
                //进行统计添加
                habitArray[index].totalJumpOverDays += remianFrequancy
                habitArray[index].lastWeekHaventDoneFrequancy = remianFrequancy
                habitArray[index].lastWeekHaventDoneTime = habitArray[index].dailyTime * remianFrequancy
            }
            //更新
            habitArray[index].thisWeekRemainFrequancy = habitArray[index].weekilyFrequency
        }
    }
    //上周未完成 
    func getLastWeekNoneFinishHabit()->[(Time,Int)]{
        return habitArray.compactMap({ habit in
            if habit.lastWeekHaventDoneFrequancy > 0 {
                return (habit.lastWeekHaventDoneTime,habit.lastWeekHaventDoneFrequancy)
            }else{
                return nil
            }
        })
    }
    //所有的坚持数据
    func getAHabitData(name:String)->(excuteTime:Time,jumpedTimes:Int,excuteDays:Int)!{
        for habit in habitArray {
            if habit.name == name {
                return (habit.totalExecuteTime,habit.totalJumpOverDays,habit.totalExecuteDays)
            }
        }
        return nil
    }
    
}

extension HabitModel {//储存代码
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = documentsDirectory.appendingPathComponent("HabitArray")
    //获取数组
    
    func getHabitDataFromDocument() -> [HabitData] {
        if let data = try? Data(contentsOf: HabitModel.ArchiveURL){
            let array = try! JSONDecoder().decode(Array<HabitData>.self, from: data)
            return array
        }else{
            return []
        }
    }
    //储存数组
    func setHabitDataToDocument(_ array:[HabitData])  {
        let data:Data? = try? JSONEncoder().encode(array)
        try! data!.write(to: HabitModel.ArchiveURL)
    }
    
}



