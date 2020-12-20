//
//  UIViewExtension.swift
//  EHealthHanAn
//
//  Created by Leo on 2019/3/21.
//  Copyright © 2019 Nanjing fist network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 从xib加载view的协议
public protocol SHViewXibabale {}
public extension SHViewXibabale {
    
    /// 从xib加载view
    static func instanceFromXib(_ name: String = "", No: Int = 0) -> Self {
        let xib = name.isEmpty ? "\(self)" : name
        return Bundle.main.loadNibNamed(xib, owner: nil, options: nil)?[No] as! Self
    }
    
}
