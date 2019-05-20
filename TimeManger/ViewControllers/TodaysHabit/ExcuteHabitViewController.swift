//
//  ExcuteHabitViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
//
//🔍

import UIKit

class ExcuteHabitViewController: UIViewController {
    
    //在上一个VC调用
    func setDataIn(habit:HabitData) {
        //配置颜色
        self.view.backgroundColor = habit.colorInt.changeToAColor()
        //title
        habitTitle = habit.name
        //今日的remainTime
        self.todayRemainTime = habit.todaysRemainTime
    }
    
    //Segue过来的数据
    var themeColor:UIColor!
    var habitTitle:String!
    var todayRemainTime:Time!
    
    //IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var excuteTimeLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var pauseAndRestartButton: UIButton!
    @IBOutlet weak var startOrEndButton: UIButton!
    @IBOutlet weak var goBackButton: UIButton!
    //MARK: - LifeCycle
    
    var needToRestart:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.imageView?.contentMode = .scaleAspectFit
        titleLabel.text = habitTitle
        remainTimeLabel.text = todayRemainTime.changeToString()
        view.backgroundColor = themeColor
        //退出重新进的时候在这里配置restart
        if needToRestart {
            BackgroundTimer.checkNeedRestart(changeInterFaceBlock: self.checkBlock){
                self.excuteTimeLabel.text = "暂停中"
                pauseAndRestartButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
            }
            needToRestart = false
        }else{
            BackgroundTimer.startTiming(changeInterFaceBlock: self.checkBlock)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //画圈圈
        circleView.addCircle(frame: circleView.bounds, fillColor:  UIColor.clear, strokeColor: UIColor.white, lineWidth: 5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    //MARK: - goback Alert
    var needToAlert:Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: "needToAlert")
        }
        get{
            if let oldData = UserDefaults.standard.object(forKey: "needToAlert") as? Bool{
                return oldData
            }else{
                UserDefaults.standard.set(true, forKey: "needToAlert")
                return true
            }
        }
    }
    
    @IBAction func goGackWithNoTime() {
        if needToAlert == false {//直接返回
            BackgroundTimer.endTiming()
            self.performSegue(withIdentifier: "unwindToToday", sender: nil)
        }
        let alert = UIAlertController(title: "提示", message: "返回之后当前执行时间将作废", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "返回", style: .destructive, handler: {(_) in
//            BackgroundTimer.endTiming()
//            self.performSegue(withIdentifier: "unwindToToday", sender: nil)
//        }))
        alert.addAction(UIAlertAction(title: "返回(下次不再提醒)", style: .destructive, handler: {(_) in
            self.needToAlert = false
            BackgroundTimer.endTiming()
            self.performSegue(withIdentifier: "unwindToToday", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- ButtonActions
    
    //Segue back
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "unwindToToday" {
            let destVC = segue.destination as! TodaysTaskViewController
            destVC.excuteHabitName = habitTitle
            if let excuteTime = sender as? Time{
                destVC.excuteTimeFromUnwind = excuteTime
            }
            if let doneIt = sender as? Bool{
                //直接完成
                destVC.unwindToFinishThisWork = doneIt
            }
        }
    }
    
    // changeTimeLabelBlock
    lazy var checkBlock:(Time)->Void = { [weak self] (time) in
        //        let second = time.second < 10 ? "0\(time.second)" : "\(time.second)"
        //        let min = time.min < 10 ? "0\(time.min)" : "\(time.min)"
        self!.excuteTimeLabel.text = "\(time.hour):\(time.min):\(time.second)"
        //更新今日剩余时间
        let newRemainTime = self!.todayRemainTime - time
        if Time() > newRemainTime {
            self!.remainTimeLabel.text = "0h0"
        }else{
            self!.remainTimeLabel.text = newRemainTime.changeToString()
        }
    }
    
    @IBAction func pushButton(sender:UIButton){
        print(sender.tag)
        //开始暂停和结束 BackGroundTimer
        switch sender.tag {
        case 0:
            if BackgroundTimer.isPausing {
                BackgroundTimer.restartTiming()
                pauseAndRestartButton.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
            }else{
                BackgroundTimer.pauseTimimg()
                pauseAndRestartButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
            }
        case 1:
            BackgroundTimer.endTiming()
            //返回数据给TodayVC
            performSegue(withIdentifier: "unwindToToday", sender: BackgroundTimer.passedTime)
        case 2:
            let alert = UIAlertController(title: habitTitle, message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "已完成", style: .destructive, handler: { (_) in
                    //返回数据给TodayVC
                    BackgroundTimer.endTiming()
                    self.performSegue(withIdentifier: "unwindToToday", sender: true)
            }))
//            alert.addAction(UIAlertAction(title: "编辑时间", style: .default, handler: { (_) in
//
//            }))
            //适配ipad
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = sender.frame
            }
            self.present(alert, animated: true, completion: nil)
        default:
            return
        }
        
    }


}
