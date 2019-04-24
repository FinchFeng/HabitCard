//
//  ViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/24.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:Timer?
    var second = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func clocking(){
        timer?.invalidate()
        second = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.second += 1
            print(" \(self.second/3600):\((self.second/60)%60):\(self.second%60)")
            self.timeLabel.text = " \(self.second/3600):\((self.second/60)%60):\(self.second%60)"
        })
    }

}

