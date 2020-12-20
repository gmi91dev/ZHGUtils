//
//  StringExtension.swift
//  BOYOU
//
//  Created by Leo on 2019/1/8.
//  Copyright © 2019 Nanjing fist network Technology Co., Ltd. All rights reserved.
//

import UIKit

public extension String {
    
    /// 字符串不为空
    var isNotEmpty: Bool { return !self.isEmpty }
    
    /// 获取字符串Int值，如果无法获取则返回0，带小数点会尝试先转double再转int
    var intValue: Int {
        
        if let intV = Int(self) {
            return intV
        } else if let doubleV = Double(self) {
            return Int(doubleV)
        } else {
            return 0
        }
        
    }
    
    /// 获取字符串Double值，如果无法获取则返回0
    var doubleValue: Double {
        if let doubleV = Double(self) {
            return doubleV
        }else {
            return 0.0
        }
    }
    
    /// json字符串转字典
    func toDic() -> Dictionary<String, Any>? {
        if let data = self.data(using: .utf8) {
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return result as? Dictionary<String, Any>
            }catch {
                DPrint("解析 jsonString 失败， error: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    /// 字符串脱敏
    func toSecurity() -> String {
        let tmp = self.replacingOccurrences(of: " ", with: "")
        guard tmp.isNotEmpty else { return "" }
        
        let lenth = tmp.count
        
        switch lenth {
        case 0, 1:
            return self
        case 2, 3, 4:
            var s = ""
            for _ in 0..<lenth {
                s += "*"
            }
            return s + self.gm_subString(from: lenth-1)
        case 5, 6:
            let head = self.gm_subString(to: 1)
            let trail = self.gm_subString(from: 4)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        case 7, 8:
            let head = self.gm_subString(to: 2)
            let trail = self.gm_subString(from: 5)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        case 9:
            let head = self.gm_subString(to: 3)
            let trail = self.gm_subString(from: 6)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        default:
            // 正常情况下的处理(前3后4中间*)
            let head = self.gm_subString(to: 3)
            let trail = self.gm_subString(from: lenth-4)
            var s = ""
            for _ in 0..<lenth-7 {
                s += "*"
            }
            return head + s + trail
        }
    }
    
    /// 获取字符串尺寸
    func getFullSize(font: UIFont, targetSize: CGSize) -> CGSize {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        let tmp = NSString(string: self)
        return tmp.boundingRect(with: targetSize, options: .usesLineFragmentOrigin, attributes: [.font: font, .paragraphStyle: style], context: nil).size
    }
    
}

// MARK: - 字符串下标操作
public extension String {
    
    /// 获取对应位置的字符串
    func gm_substring(at index: Int) -> String {
        guard index < self.count else { return "" }
        let idx = self.index(startIndex, offsetBy: index)
        return String(self[idx])
    }
    
    /// 从第几个开始截取字符串到最后个
    func gm_subString(from index: Int) -> String {
        guard index < self.count else {
            return ""
        }
        return self[index..<self.count]
    }
    
    /// 从第一个开始截取字符串到第几个
    func gm_subString(to index: Int) -> String {
        guard index < self.count else {
            return ""
        }
        return self[0..<index]
    }
    
    /// 直接获取某个位置的Index，当这个Index超出startIndex和endIndex时会返回空，注意字符串endIndex是结束符而不是最后一个字符
    func gm_index(_ position: Int) -> Index? {
        // 字符串"012"Index的范围是(0,1)到(3,0)
        guard position >= 0, position <= self.count else {
            return nil
        }
        return self.index(self.startIndex, offsetBy:position)
    }
    
    /// 提供substring的下标便捷方式，半闭合区间，当超出范围会返回""或什么都不做
    subscript (r: Range<Int>) -> String {
        get {   // 获取
            if let idxStart = self.gm_index(r.lowerBound), let idxEnd = self.gm_index(r.upperBound) { // 保证在范围内
                return String(self[idxStart..<idxEnd])
            }
            return ""
        }
        
        set {   // 设置
            if let idxStart = self.gm_index(r.lowerBound), let idxEnd = self.gm_index(r.upperBound) {
                let range = idxStart...idxEnd
                self.replaceSubrange(range, with: "")
            }
        }
    }
    
}

// MARK: - 身份证相关
public extension String {
    
    /// 是否是身份证号
    var isIdNo: Bool { return predicate(matched: "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)") }
    
    /// 验证字符串是否是身份证，如果是就返回原字符串，否则返回""
    func judgeIdNo() -> String { guard self.isIdNo else { return "" }; return self }
    
    /// 是否是女性
    var isFemale: Bool {
        guard isNotEmpty else { return false }
        if self.count == 15 {
            let tmp = self.gm_substring(at: self.count - 1)
            let tmpInt = Int(tmp) ?? 0
            return (tmpInt % 2 == 0)
        }else {
            let tmp = self.gm_substring(at: self.count - 2)
            let tmpInt = Int(tmp) ?? 0
            return (tmpInt % 2 == 0)
        }
    }
    
    /// 从身份证号获取出生日期, 获取失败就返回今天的日期
    func getBirthdayDate() -> Date {
        guard self.count >= 15 else {
            return Date()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        var dateStr = ""
        if self.count == 15 {
            dateStr = "19" + self[6..<12]
        }else {
            dateStr = self[6..<14]
        }
        
        if let birthDate = formatter.date(from: dateStr) {
            return birthDate
        }
        
        return Date()
    }
    
    /// 根据身份证获取年龄
//    public func getAge() -> Int {
//        let birthDate = getBirthdayDate()
//        let today = Date()
//
//        var age = today.year - birthDate.year
//        if today.month < birthDate.month { age -= 1 }
//        return age
//    }
    
}

// MARK: - url
public extension String {
    // URL Encode
    func URLEncode(characters: String = "!*'\"();@+$,%[]% ") -> String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: characters).inverted) ?? ""
    }
}

// MARK: - 正则表达式
public extension String {
    
    /// 字符串是否是url
    var isUrl: Bool {
        return predicate(matched: "(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}")
    }
    
    /// 是否是电话号码
    var isPhoneNumber: Bool { return predicate(matched: "^1+[35789]+\\d{9}") }
    
    /// 正则匹配
    func predicate(matched pattern: String) -> Bool {
        let tmp = self.replacingOccurrences(of: " ", with: "")
        guard tmp.isNotEmpty else {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with:self)
    }
    
}

// MARK: - 处理汉语拼音
public extension String {
    
    /// 拼音首字母(大写)
    var firstLetter: String {
        let pinyinStr = toPinYin()
        let first = pinyinStr.gm_substring(at: 0)
        if first.predicate(matched: "^[a-zA-Z]") {
            return first.uppercased()
        }
        return "#"
    }
    
    /// 将汉语转换成拼音(tone: 是否带声调)
    func toPinYin(tone: Bool = false, first: Bool = false) -> String {
        var tmp = self
        if first {
            // 自定义
            tmp = polyphoneString(tone: tone)
        }
        let cfStr = CFStringCreateMutableCopy(nil, 0, tmp as CFString)
        // 转换成带声调的拼音
        CFStringTransform(cfStr, nil, kCFStringTransformToLatin, false)
        /// 去掉声调
        if !tone {
            CFStringTransform(cfStr, nil, kCFStringTransformStripCombiningMarks, false)
        }
        return (cfStr as String?) ?? ""
    }
    
    /// 自定义汉子首字母处理
    private func polyphoneString(tone: Bool = false) -> String {
        if self.hasPrefix("重") {return tone ? "chóng": "chong"}
        return self
    }

  
}
