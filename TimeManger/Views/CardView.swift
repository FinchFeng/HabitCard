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
    
    //配置数据
    func setDatas(title:String,todayRemain:Time,weekilyRemainFrequancy:Int,color:UIColor) {
        self.title.text = title
        dailyTime.text = todayRemain.changeToString()
        weekilyTime.text = "\(weekilyRemainFrequancy)"
        cardBackgroundView.backgroundColor = color
    }
    
    @IBAction func moreAcation(){
        //在链接VC的时候使用搞一个block 🔧
        print("MoreActions")
    }
    
    
}
