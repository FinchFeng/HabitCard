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
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let app = UIApplication.shared
        self.bgTask = app.beginBackgroundTask(expirationHandler: {
            app.endBackgroundTask(self.bgTask)
            self.bgTask = UIBackgroundTaskIdentifier.invalid
        })
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(applyForMoreTime), userInfo: nil, repeats: true)
    }
    
    
    @objc func applyForMoreTime(){
        if UIApplication.shared.backgroundTimeRemaining < 3010 {//时间小于一定数目
//            print("applyForMoreTime")
//            print(UIApplication.shared.backgroundTimeRemaining)
            //播放一次
            let url = Bundle.main.url(forResource: "1", withExtension: "mp3")!
            do {
                try AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.playback,//这个模式锁屏和静音模式下可以继续播放
                    mode: .default,
                    options: [AVAudioSession.CategoryOptions.mixWithOthers])
            } catch {
                print("Failed to set audio session category.  Error: \(error)")
            }
            do {
                try self.andioPlayer = AVAudioPlayer(contentsOf: url)
            }catch{
                print("Failed to set audio session category.  Error: \(error)")
            }
            self.andioPlayer.play()
            //重新设定一次bgTask
            UIApplication.shared.endBackgroundTask(self.bgTask)
            self.bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                UIApplication.shared.endBackgroundTask(self.bgTask)
                 self.bgTask = UIBackgroundTaskIdentifier.invalid
            })
            
        }
    }


}

