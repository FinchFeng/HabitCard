//
//  AddNewHabitViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
// 对5s屏幕进行适配 🔧

import UIKit

class AddNewHabitViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    

    @IBOutlet weak var newHabitTextField: UITextField!
    @IBOutlet weak var newHabitDailyTimeField: UITextField!
    @IBOutlet weak var newHabitWeeklyFrequencyField: UITextField!
    @IBOutlet weak var circleView: UIView!
    
    let delegateClass = TextFieldDoneDelegateClass()
    
    //判断是不是来修改数据的
    var oldData:HabitData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.addCircle(frame: circleView.bounds, fillColor: UIColor.lightGray, strokeColor: UIColor.clear, lineWidth: 0)
        newHabitDailyTimeField.delegate = self
        //赋值为另外一个Class 的delegate
        newHabitTextField.delegate = delegateClass
        newHabitWeeklyFrequencyField.delegate = delegateClass
        //判定修改数据
        if let data = oldData {
            newHabitTextField.text = data.name
            let dailyTimeInSecond = Int(data.dailyTime.changeToSecond())
            newHabitDailyTimeField.text = "\(dailyTimeInSecond/3600):\((dailyTimeInSecond/60)%60)"
            newHabitWeeklyFrequencyField.text = "\(data.weekilyFrequency)"
        }
    }
    
   
    
    
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "unwindToTodayFromAdding" , let newData = sender! as? HabitData {
            let todaysVC = segue.destination as! TodaysTaskViewController
            //在这里直接添加
            if oldData == nil {
                todaysVC.model.addHabit(newData)
            }else{
                todaysVC.needToPopHabitDetailVC = true
                todaysVC.model.changeHabit(oldName: oldData!.name, newHabit: newData)
            }
        }
        //bool是oldata是否为nil
        if segue.identifier! == "unwindToTodayFromAdding" , let bool = sender as? Bool,bool == false{
            let todaysVC = segue.destination as! TodaysTaskViewController
            todaysVC.needToPopHabitDetailVC = true
        }
    }
    
    //检查名称的闭包 segue的时候配置
    var checkNameBlock:((String)->Bool)!
    
    @IBAction func doneAction() {
        print("unwind with a new habit data")
        //返回一个新习惯数据
        //检查新名称是否可以使用
        if let frequency = Int(newHabitWeeklyFrequencyField.text ?? "") , (frequency > 0) ,frequency < 8{
            //检查一下有没有同名
            if let name =  newHabitTextField.text {
                if checkNameBlock(name){
                    //获取小时和分钟
                    let timeString = newHabitDailyTimeField.text!
                    let newHabitData = HabitData(name: newHabitTextField.text ?? "",
                                                 dailyTime: timeString.changeToTime(),
                                                 weekilyFrequency:frequency,
                                                 color: ConstantsColor.getAColor())
                    //unwind新的habit
                    performSegue(withIdentifier: "unwindToTodayFromAdding", sender: newHabitData)
                }else{
                    //有同名
                    showMassage("此名字被使用过了")
                }
            }else{
                //没有输入名称
                showMassage("没有输入名称")
            }
            
        }else{
            showMassage("每周次数不能超过7")
        }
        
    }
    
    func showMassage(_ word:String){
        let controller = UIAlertController(title: "注意", message: word, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton() {
        performSegue(withIdentifier: "unwindToTodayFromAdding", sender: oldData == nil)
    }
    
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        print("tap screen")
        newHabitTextField.resignFirstResponder()
        newHabitWeeklyFrequencyField.resignFirstResponder()
        newHabitDailyTimeField.resignFirstResponder()
    }
    
    //MARK: - UITextFeild Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //展示一个pikerView
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 250)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "选择时间长度", message: "", preferredStyle: .alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "完成", style: .default, handler: {(_) in
            self.newHabitDailyTimeField.text = "\(pickerView.selectedRow(inComponent: 0)):\(pickerView.selectedRow(inComponent: 1))"
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
        return false
    }
    
    //MARK: -  PickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 20 : 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = component == 0 ? "\(row)h" : "\(row)m"
        return result
    }
    
}

class TextFieldDoneDelegateClass:NSObject,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
