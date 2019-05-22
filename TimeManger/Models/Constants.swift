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
    // cards
    static var todayRemain = isLanguageChinese ? "今天" : "Today"
    static var thisWeek = isLanguageChinese ? "本周" : "Week"
    // 上周未完成和已经坚持
    static var lastweek = isLanguageChinese ? "上周未完成" : "Not completed last week"
    static var allHabit = isLanguageChinese ? "已经坚持" : "Has insisted"
    // 二级页面
    static var todaysTime = isLanguageChinese ? "今日剩余" : "Remaining today"
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

