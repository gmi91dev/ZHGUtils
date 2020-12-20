//
//  NotificationExtension.swift
//  EHealthHanAn
//
//  Created by Leo on 2019/3/21.
//  Copyright © 2019 Nanjing fist network Technology Co., Ltd. All rights reserved.
//
// 通知名称统一写在这里

import Foundation

public protocol NotificationNamable {
    var notiName: String {get}
}

public extension NotificationNamable {
    /// 系统通知名称
    var sysNotiName: Notification.Name {
        return Notification.Name(rawValue: self.notiName)
    }
}

/// 扩展通知中心方法
public extension NotificationCenter {
    /// 发送自定义通知
    func zhg_post(notifation name: NotificationNamable, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name.sysNotiName, object: object, userInfo: userInfo)
    }
    
    /* 添加监听者 */
    func zhg_add(observer: Any, selector: Selector, customName: NotificationNamable, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: customName.sysNotiName, object: object)
    }
    
}
