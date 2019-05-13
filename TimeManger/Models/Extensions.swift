//
//  Extensions.swift
//  TimeManger
//
//  Created by 冯奕琦 on 2019/5/4.
//  Copyright © 2019 冯奕琦. All rights reserved.
//

import Foundation
import UIKit

//extension Date {
//    static func getLocalTime()->Date{
//        let timeInterval:TimeInterval = Double(TimeZone.current.secondsFromGMT())
//        return Date()+timeInterval
//    }
//}


extension UIView{
    //传入子View的Frame
    func addCircle(frame:CGRect,fillColor:UIColor,strokeColor:UIColor,lineWidth:CGFloat){
        let oval = UIBezierPath(ovalIn: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = oval.cgPath
        //change the fill color
        shapeLayer.fillColor = fillColor.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = strokeColor.cgColor
        //you can change the line width
        shapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
