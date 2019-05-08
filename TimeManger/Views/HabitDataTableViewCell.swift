//
//  HabitDataTableViewCell.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/8.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class HabitDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var habitTitle: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    func setDataIn(){//🔧
        //读入这些数据 设置颜色什么的
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //Segue
        
    }

}
