//
//  DictionaryExtension.swift
//  EHealthHanAn
//
//  Created by Leo on 2019/3/24.
//  Copyright © 2019 Nanjing fist network Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// 转json字符串
    func toJsonString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            return jsonStr ?? ""
        }catch {
            return ""
        }
    }

}
