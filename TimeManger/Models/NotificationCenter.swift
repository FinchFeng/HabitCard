//
//  NotificationCenter.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/6/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class AppNotification{
    
    //🔧可以关闭这个功能
    
    static var notification = UNUserNotificationCenter.current()
    static func requestAuthorityAgain(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.alertSetting != .enabled {
                //打开设置页面
                print("无权限")
                let alertController = UIAlertController(title: ConstantsWord.attention, message: ConstantsWord.getAuthority, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: ConstantsWord.cancel, style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: ConstantsWord.good, style: .default, handler: { (_) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }))
                UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge]) {
                granted, error in
                print("Permission granted: \(granted)")
        }
    }
    
    static func changeBadge(to number:Int){
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
    //提醒有关
    static var userDefault = UserDefaults.standard
    static var gap:Int{
        get{
            //注意初始化 检查是否为nil
            if let oldData = userDefault.object(forKey: "gap") as? Int {
                return oldData
            }else{
                let firstData = 2
                userDefault.set(firstData, forKey: "gap")
                return firstData
            }
        }
        set{
            userDefault.set(newValue, forKey: "gap")
        }
    }
    //方法
    
    
    static func schedulingNotifications(message:String){//gap在设置里面设定
        notification.removeAllPendingNotificationRequests()
        //以间隔安排notification 8到24点
    }
    
    static func addANotification(timePoint:Int,message:String){
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = timePoint    // 14:00 hours
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print("something wrong")
            }
        }
    }
    
    
}

