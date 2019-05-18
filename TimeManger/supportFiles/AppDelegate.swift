//
//  AppDelegate.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/24.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
import AVFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var bgTask:UIBackgroundTaskIdentifier!
    var andioPlayer:AVAudioPlayer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //啥都不做
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        //检查是否更新
        TimeChecker.checkUpdate()
    }
    
    

}

