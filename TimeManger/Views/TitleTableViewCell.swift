//
//  TitleTableViewCell.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/8.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    func set(title:String) {
        self.title.text = title
    }
}
