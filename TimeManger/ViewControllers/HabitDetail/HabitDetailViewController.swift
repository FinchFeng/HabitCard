//
//  HabitDetailViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
// 🔍


import UIKit

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var habitData:HabitData!
    var themeColor:UIColor! = #colorLiteral(red: 0.1034872308, green: 0.3690240681, blue: 0.5518581867, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //配置右上角的按钮
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "moreButtonForDetailView"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(tapMoreButton))
        navigationItem.rightBarButtonItem = button
        //更改bar的颜色和title的颜色
        themeColor = habitData.colorInt.changeToAColor()
        title = habitData.name
        themeColor = habitData.colorInt.changeToAColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //展示数据
        let gap:CGFloat = 30
        var lastLine = createALabelGroup(title: "总执行时间", message: habitData.totalExecuteTime.changeToString(), yPosition: 30)
        lastLine = createALabelGroup(title: "跳过次数", message: "\(habitData.totalJumpOverDays)次", yPosition: lastLine+gap)
        lastLine = createALabelGroup(title: "坚持天数", message: "\(habitData.totalExecuteDays)天", yPosition: lastLine+gap)
        //最后创建contentSize
        scrollView.contentSize = CGSize(width: Constants.screenWidth, height: lastLine+gap)
    }
    
    func createALabelGroup(title:String,message:String,yPosition:CGFloat)->CGFloat{
        //title
        let newTitleLabel = UILabel()
        newTitleLabel.font = UIFont.systemFont(ofSize: 29, weight: .medium)
        newTitleLabel.textColor = themeColor
        newTitleLabel.text = title
        newTitleLabel.center = CGPoint(x: scrollView.bounds.size.width/2, y: yPosition)
        newTitleLabel.bounds.size = CGSize(width: Constants.screenWidth, height: 30)
        newTitleLabel.textAlignment = .center
        scrollView.addSubview(newTitleLabel)
        //circle
        let gap:CGFloat = 18
        let circleSize = scrollView.bounds.width*0.6
        let circleFrame = CGRect(origin: CGPoint(x: scrollView.bounds.size.width/2-circleSize/2, y: gap+newTitleLabel.frame.maxY), size: CGSize(width: circleSize, height: circleSize))
        scrollView.addCircle(frame: circleFrame, fillColor: UIColor.clear, strokeColor: themeColor, lineWidth: 5.6)
        //message
        let newMessageLabel = UILabel()
        newMessageLabel.center = CGPoint(x: circleFrame.midX, y: circleFrame.midY)
        newMessageLabel.font = UIFont.systemFont(ofSize: 37, weight: .medium)
        newMessageLabel.textColor = themeColor
        newMessageLabel.text = message
        newMessageLabel.bounds.size = CGSize(width: Constants.screenWidth, height: 30)
        newMessageLabel.textAlignment = .center
        scrollView.addSubview(newMessageLabel)
        //返回最后一排
        return circleFrame.maxY
    }
    
    
    var checkNameBlock:((String)->Bool)!
    //配置修改习惯和删除习惯的功能
    @objc func tapMoreButton(){
        let alert = UIAlertController(title: "\(habitData.name)", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "编辑此习惯", style: .default, handler: { (_) in
            //到添加习惯页面去更改
            self.performSegue(withIdentifier: "editHabit", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "删除此习惯", style: .destructive, handler: { (_) in
            
            self.performSegue(withIdentifier: "backToHabitData", sender: self.habitData.name)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "backToHabitData"{
            if let name = sender as? String{
                let upVC = segue.destination as! HabitDataViewController
                //删除这个习惯
                upVC.model.deleteHabit(name: name)
            }
        }else if segue.identifier! == "editHabit"{
            //更改习惯
            let destVC = segue.destination as! AddNewHabitViewController
            destVC.checkNameBlock = self.checkNameBlock
            destVC.oldData = habitData
        }
    }

}
