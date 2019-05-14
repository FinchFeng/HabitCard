//
//  AddNewHabitViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//
//unwind 对5s屏幕进行适配 🔧

import UIKit

class AddNewHabitViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    

    @IBOutlet weak var newHabitTextField: UITextField!
    @IBOutlet weak var newHabitDailyTimeField: UITextField!
    @IBOutlet weak var newHabitWeeklyFrequencyField: UITextField!
    @IBOutlet weak var circleView: UIView!
    
    let delegateClass = TextFieldDoneDelegateClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.addCircle(frame: circleView.bounds, fillColor: UIColor.lightGray, strokeColor: UIColor.clear, lineWidth: 0)
        newHabitDailyTimeField.delegate = self
        //赋值为另外一个Class 的delegate
        newHabitTextField.delegate = delegateClass
        newHabitWeeklyFrequencyField.delegate = delegateClass
    }
    
    @IBAction func doneAction() {
        print("unwind with a new habit data")
        //返回一个新习惯数据🔧
        
    }
    
    @IBAction func cancelButton() {
        
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
