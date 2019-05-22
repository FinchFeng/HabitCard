//
//  SettingsViewController.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/3.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    

    //配置设置Cell
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK:Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = indexPath.row==0 ? "contactUs" : "changeUpdateTime"
        let cell = tableView.dequeueReusableCell(withIdentifier: id)!
        if indexPath.row == 1{
            cell.detailTextLabel?.text = "\(TimeChecker.dailyUpdateTime):00"
        }
        return cell
    }
    var alert:UIAlertController?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //出现一个联系框与后台进行反馈
            let alert = UIAlertController(
                title: "联系我们",
                message: nil,
                preferredStyle: .alert
            )
            self.alert = alert
            alert.addAction(UIAlertAction(
                title: "发送",
                style: .default)
            { (action: UIAlertAction) -> Void in
                //从父ViewController中获取TextFields
                if let tf = self.alert?.textFields?.first {
                    //发送信息
                    if let text = tf.text {
                        Network.contactUs(string: text)
                    }
                }
            } )
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "请输入您的建议"
            })
            alert.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        if indexPath.row == 1 {
            //展示一个pikerView
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 250,height: 250)
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            pickerView.delegate = self
            pickerView.dataSource = self
            vc.view.addSubview(pickerView)
            let editRadiusAlert = UIAlertController(title: "选择每天更新时间点", message: "", preferredStyle: .alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "完成", style: .default, handler: {(_) in
                let newHour = Int(pickerView.selectedRow(inComponent: 0))
                print(newHour)
                //设置新时间
                TimeChecker.dailyUpdateTime = newHour
                print(TimeChecker.currentNextDaliyDate.description(with: Locale.current))
                self.tableView.reloadData()
            }))
            editRadiusAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.present(editRadiusAlert, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:pickerView delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

}


class Network {
    static func contactUs(string:String){
        let backendURL = "http://118.25.71.200/location/"
        //处理string
        let newString = string.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        let url = backendURL + "contact/?iglooID=642430817&content="+newString
        
//        //发送函数
        let requestURL = URL(string: url)!
        let task = URLSession.shared.dataTask(with: requestURL)
        task.resume()
    }
}
