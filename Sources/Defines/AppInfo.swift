//
//  ZHGApplication.swift
//  SwiftUIDataBaseDemo
//
//  Created by 郑恒 on 2020/12/7.
//  Copyright © 2020 ZHG. All rights reserved.
//

import Foundation

public struct AppInfo {
    private init() {}
    
    public static let infoDictionary = Bundle.main.infoDictionary
    // App 名称
    public static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    // Bundle Identifier
    public static let bundleIdentifier:String = Bundle.main.bundleIdentifier ?? ""
    // App 版本号
    public static let version: String = infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    // Bulid 版本号
    public static let buildVersion: String = infoDictionary?["CFBundleVersion"] as? String ?? ""
}


