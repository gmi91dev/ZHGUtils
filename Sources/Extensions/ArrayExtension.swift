//
//  ArrayExtension.swift
//  ESHosAppSkq
//
//  Created by Leo on 2018/7/12.
//  Copyright © 2018年 SunnyHealth. All rights reserved.
//

import UIKit

public extension Array {
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

public extension Array where Element == String {
    /// 返回根据首字母分好组的字典
    func groupByFirstLetter() -> Dictionary<String, [String]> {
        var dic = Dictionary<String, [String]>()
        for item in self {
            let first = item.firstLetter
            if dic[first] != nil {
                dic[first]?.append(item)
            }else {
                dic[first] = [item]
            }
        }
        return dic
    }
}
