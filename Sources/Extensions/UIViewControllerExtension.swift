//
//  UIViewControllerExtension.swift
//  EHealthHanAn
//
//  Created by Leo on 2019/3/21.
//  Copyright © 2019 Nanjing fist network Technology Co., Ltd. All rights reserved.
//

import UIKit

// MARK: - 从 Storyboard 加载
public protocol SHStoryboardable {}
public extension SHStoryboardable where Self: UIViewController {
    
    /// 从 Storyboard 加载/
    static func instanceFromStoryboard(named sbName: String) -> Self {
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "\(self)")
        return vc as! Self
    }
    
}

// MARK: - 导航栏按钮
public extension UIViewController {
    
    @discardableResult
    final func addLeftNaviBarButton(image: UIImage? = nil, title: String? = nil, action: Selector? = nil) -> UIBarButtonItem? {
        return addNaviBarItem(image: image, title: title, action: action, isleft: true)
    }
    
    @discardableResult
    final func addRightNaviBarButton(image: UIImage? = nil, title: String? = nil, action: Selector? = nil) -> UIBarButtonItem? {
        return addNaviBarItem(image: image, title: title, action: action, isleft: false)
    }
    
    final func addCustomLeftNaviBarItem(_ view: UIView) {
        addCustomNaviBarItem(view, isleft: true)
    }
    
    final func addCustomRightNaviBarItem(_ view: UIView) {
        addCustomNaviBarItem(view, isleft: false)
    }
    
    /// 添加自定义导航栏按钮
    private func addCustomNaviBarItem(_ view: UIView, isleft: Bool) {
        let newItem = UIBarButtonItem(customView: view)
        addNaviBarItem(newItem, isleft: isleft)
    }
    
    /// 添加系统导航栏item
    private func addNaviBarItem(image: UIImage?, title: String?, action: Selector?, isleft: Bool) -> UIBarButtonItem? {
        guard let newItem = getBarButton(image: image, title: title, action: action) else { return nil }
        addNaviBarItem(newItem, isleft: isleft)
        return newItem
    }
    
    /// 添加导航栏按钮
    private func addNaviBarItem(_ newItem: UIBarButtonItem, isleft: Bool) {
        if isleft {
            // 设置导航条左上角按钮
            if var items = navigationItem.leftBarButtonItems, items.count > 0 {
                items.append(newItem)
                navigationItem.leftBarButtonItems = items
            }else if let item = navigationItem.leftBarButtonItem {
                navigationItem.leftBarButtonItems = [item, newItem]
            }else {
                navigationItem.leftBarButtonItem = newItem
            }
        }else {
            // 设置导航条右上角按钮
            if var items = navigationItem.rightBarButtonItems, items.count > 0 {
                items.append(newItem)
                navigationItem.rightBarButtonItems = items
            }else if let item = navigationItem.rightBarButtonItem {
                navigationItem.rightBarButtonItems = [item, newItem]
            }else {
                navigationItem.rightBarButtonItem = newItem
            }
        }
    }
    
    /// 创建bar button
    private func getBarButton(image: UIImage?, title: String?, action:Selector?) -> UIBarButtonItem? {
        var barButton: UIBarButtonItem?
        if image != nil {
            barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        } else if title != nil {
            barButton = UIBarButtonItem(title: title!, style: .plain, target: self, action: action)
        }
        return barButton
    }
    
}
