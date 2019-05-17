//
//  CardView.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/6.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class CardView: UICollectionViewCell {
    
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dailyTime: UILabel!
    @IBOutlet weak var weekilyTime: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.clipsToBounds = false
        cardBackgroundView.layer.cornerRadius = 8
        //阴影
        cardBackgroundView.layer.masksToBounds = false //不让边缘切割子图层（阴影）
        cardBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cardBackgroundView.layer.shadowOpacity = 0.5
        cardBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 4)
        cardBackgroundView.layer.shadowRadius = 4//模糊程度
    }
    
    var habitData:HabitData!
    //配置数据
    func setDatas(data:HabitData) {
        self.habitData = data
        self.title.text = data.name
        dailyTime.text = data.todaysRemainTime.changeToString()
        weekilyTime.text = "\(data.thisWeekRemainFrequancy)"
        cardBackgroundView.backgroundColor = data.colorInt.changeToAColor()
    }
    
    func setBlocks(todayDoneBlock:((String)->Void)!
        ,jumpTodayBlock:((String)->Void)!,
         goToDetailVC:((HabitData)->Void)!){
        self.todayDoneBlock = todayDoneBlock
        self.jumpTodayBlock = jumpTodayBlock
        self.goToDetailVC = goToDetailVC
    }
    
    //moreAction
    
    var todayDoneBlock:((String)->Void)!
    var jumpTodayBlock:((String)->Void)!
    var goToDetailVC:((HabitData)->Void)!
    
    @IBAction func moreAcation(){
        print("MoreActions")
        let alertController = UIAlertController(title: "工作卡片", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "今天跳过此习惯", style: .destructive, handler: { (_) in
            self.jumpTodayBlock(self.habitData.name)
        }))
        alertController.addAction(UIAlertAction(title: "已完成此习惯", style: .default, handler: { (_) in
            self.todayDoneBlock(self.habitData.name)
        }))
        alertController.addAction(UIAlertAction(title: "查看或编辑此习惯", style: .default, handler: { (_) in
            self.goToDetailVC(self.habitData)
        }))
        //使用当前的vc展示
        let topVC = UIApplication.topViewController()!
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = topVC.view
            popoverController.sourceRect = self.frame
        }
        topVC.present(alertController, animated: true, completion: nil)
    }
    
    
}
