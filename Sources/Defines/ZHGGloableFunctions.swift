//
//  ZHGGloableDefine.swift
//  SwiftUIDataBaseDemo
//
//  Created by 郑恒 on 2020/12/7.
//  Copyright © 2020 ZHG. All rights reserved.
//

import Foundation
import UIKit

/// 只在debug中打印(打印完立即换行)
public func DPrint(_ item: @autoclosure () -> Any) {
    #if DEBUG
    print(item())
    #endif
}

/// 打印所有实例变量列表
public func LogIvarList(classString:String) {
    #if DEBUG
    print("\n\n ********** \(classString)  IvarList ****************\n")
    
    var count:UInt32 = 0
    let list = class_copyIvarList(NSClassFromString(classString), &count)
    for i in 0 ..< Int(count) {
        let ivar = list![i]
        let name = ivar_getName(ivar)
        let type = ivar_getTypeEncoding(ivar)
        print( String(cString: name!),"-----",String(cString: type!),"\n")
    }
    #endif
}

/// 打印属性列表
public func LogPropertyList(classString:String) {
    #if DEBUG
    print("\n\n ********** \(classString)  PropertyList ****************\n")
    var count:UInt32 = 0
    let list = class_copyPropertyList(NSClassFromString(classString), &count)
    for i in 0 ..< Int(count) {
        let property = list![i]
        let name = property_getName(property)
        let type = property_getAttributes(property)
        print( String(cString: name),"------",String(cString: type!),"\n")
    }
    #endif
}
