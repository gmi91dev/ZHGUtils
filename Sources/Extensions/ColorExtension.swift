//
//  ColorExtension.swift
//  JKWYHosNYSKQ
//
//  Created by ZhengHeng on 2018/5/28.
//  Copyright © 2018年 Jiangsu Sunny Health Network Technology Co.,Ltd. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// 随机色
    static var randomColor: UIColor {
        let redValue = CGFloat(arc4random_uniform(100)) / 100.0
        let greenValue = CGFloat(arc4random_uniform(100)) / 100.0
        let blueValue = CGFloat(arc4random_uniform(100)) / 100.0
        let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
        return color
    }
    
    /// 16进制颜色
    convenience init(hex: Any, alpha: CGFloat = 1.0) {
        
        if let hexString = hex as? String {
            var cString = hexString.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
            
            if cString.hasPrefix("#") {
                let index = cString.index(cString.startIndex, offsetBy:1)
                cString = String(cString[index...])
            }
            
            if cString.hasPrefix("0x") || cString.hasPrefix("0X") {
                let index = cString.index(cString.startIndex, offsetBy:2)
                cString = String(cString[index...])
            }
            
            if (cString.count == 6) {
                let rIndex = cString.index(cString.startIndex, offsetBy: 2)
                let rString = String(cString[..<rIndex])
                let otherString = String(cString[rIndex...])
                let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
                let gString = String(otherString[..<gIndex])
                let bIndex = cString.index(cString.endIndex, offsetBy: -2)
                let bString = String(cString[bIndex...])

                var intr: UInt64 = 0, intg: UInt64 = 0, intb: UInt64 = 0;
                Scanner(string: rString).scanHexInt64(&intr)
                Scanner(string: gString).scanHexInt64(&intg)
                Scanner(string: bString).scanHexInt64(&intb)

                let red = CGFloat(intr) / 255.0
                let green = CGFloat(intg) / 255.0
                let blue = CGFloat(intb) / 255.0
                
                self.init(red: red, green: green, blue: blue, alpha: alpha)
            }else {
                self.init(white: 1, alpha: alpha)
            }
        }else if let hexInt = hex as? Int {
            let r = (hexInt & 0xFF0000) >> 16
            let g = (hexInt & 0xFF00) >> 8
            let b = hexInt & 0xFF
            
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }else {
            self.init(white: 1, alpha: alpha)
        }
    }
    
}
