//
//  ViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/4/24.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func clocking(){
        BackgroundTimer.startTiming { (time) in
            self.timeLabel.text = "\(time.hour):\(time.min):\(time.second)"
        }
    }

    @IBAction func stopIt(_ sender: UIButton) {
        BackgroundTimer.stoptiming()
    }
}

