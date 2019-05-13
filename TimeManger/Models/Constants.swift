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
    //Cards
    static var cardsRadio:CGFloat = 0.87
    static var cardsDistance:CGFloat = 0.13
    
}



struct ConstantsColor {
    
    private static var currentUsingColorInt:Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "currentUsingColorInt")
        }
        get{
            if let oldData = UserDefaults.standard.object(forKey: "currentUsingColorInt") as? Int{
                return oldData
            }else{
                UserDefaults.standard.set(0, forKey: "currentUsingColorInt")
                return 0
            }
        }
    }
    
    static var colorsArray = [#colorLiteral(red: 0.1034872308, green: 0.3690240681, blue: 0.5518581867, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    //获取新的Color
    static func getAColor()->UIColor{
        let currentOldColorInt = currentUsingColorInt
        let newColorInt = (currentOldColorInt == colorsArray.count-1 ? 0 : currentOldColorInt+1)
        currentUsingColorInt = newColorInt
        return newColorInt.changeToAColor()
    }
    
}

extension Int {
    func changeToAColor() -> UIColor {
        return ConstantsColor.colorsArray[self]
    }
}

extension UIColor{
    func changeToAInt() -> Int! {
        for (index,color) in ConstantsColor.colorsArray.enumerated(){
            if color == self{
                return index
            }
        }
        print("系统没有这个颜色")
        return nil
    }
}

