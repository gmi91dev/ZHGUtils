//
//  DateExtension.swift
//  ESHosAppSkq
//
//  Created by Leo on 2018/6/23.
//  Copyright © 2018年 SunnyHealth. All rights reserved.
//

import Foundation

// MARK: - 类方法
public extension Date {
    
    /// 获取时间戳字符串(1970)
    static func getTimeIntervalStringSince1970() -> String {
        let time = Date().timeIntervalSince1970
        return String(format: "%ld", Int(time))
    }
    
}

// MARK: - 实例方法
public extension Date {
    
    /// 转格式好的字符串
    func toString(_ format: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
    
}
