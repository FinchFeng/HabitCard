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
    
    //总习惯数组(直接储存和获取)
    var habitArray:[HabitData] {
        set{
            setHabitDataToDocument(newValue)
        }
        get{
            return getHabitDataFromDocument()
        }
    }
    
    //MARK:总习惯更改代码
    //修改某一个习惯
    func changeHabit(_ newHabit:HabitData){
        for (index,existHabit) in habitArray.enumerated(){
            if existHabit.name == newHabit.name {
                habitArray[index] = newHabit
                return
            }
        }
    }
    //添加一个习惯
    func addHabit(_ habit:HabitData)->Bool{
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
            return !habit.todayNeedToDisplay
        })
    }
    //今日习惯刷新代码 写入数据（记录未完成的时间和次数加入 总习惯数组的上周未完成 更改todayHaveDone）
    
    //增加时间（要是时间超过直接完成）
    //跳过某个习惯
    
    //直接完成
    func todayDone(habitName:String) {
        for habit in habitArray{
            if habit.name == habitName {
                habit.todayNeedToDisplay = false
                habit.thisWeekRemainFrequancy -= 1
                assert(habit.thisWeekRemainFrequancy >= 0)
                return
            }
        }
    }
    //MARK:获取习惯统计数据
    
    //每周清零一次
    //上周未完成
    
    //所有的坚持数据
    
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



