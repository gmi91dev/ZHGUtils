//
//  GMView.swift
//  SHDiseasePrevention
//
//  Created by zhengheng on 2020/2/21.
//  Copyright © 2020 Jiangsu Sunny Health Network Technology Co.,Ltd. All rights reserved.
//
//  该view集成了圆角，描边，阴影，渐变背景色等属性，均可在xib上设置

import UIKit

//@IBDesignable
public class GMView: UIView {

    /// 圆角大小
    @IBInspectable var cornerRadius: CGFloat = 0.0
    /// 描边宽度
    @IBInspectable var borderWidth: CGFloat = 0.0
    /// 描边颜色
    @IBInspectable var borderColor: UIColor = .darkGray
    
    /// 阴影颜色
    @IBInspectable var shadowColor: UIColor = UIColor.black
    /// 阴影偏移量
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    /// 阴影透明度
    @IBInspectable var shadowOpacity: Float = 0
    /// 阴影半径
    @IBInspectable var shadowRadius: CGFloat = 6
    
    /** --- 背景渐变色相关 --- */
    /// 渐变色初始色
    @IBInspectable var gradientStartColor: UIColor?
    /// 渐变色结束色
    @IBInspectable var gradientEndColor: UIColor?
    /// 背景渐变色
    var gradientColors = Array<UIColor>()
    /* 渐变起始和结束位置point值坐标解释
     (0, 0)|--------|(1, 0)
           |        |
           |        |
     (0, 1)|--------|(1, 1)
     */
    /// 渐变开始坐标
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0)
    /// 渐变结束坐标
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1)
    
    /// 渐变色layer
    private var gradientLayer = CAGradientLayer()
    /** --- 背景渐变色相关 --- */
    
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadiusAndBorder()
        setGradientLayer()
        
    }
    
    /// 设置背景渐变色
    private func setGradientLayer() {
        guard gradientColors.count > 0 || (gradientStartColor != nil && gradientEndColor != nil) else {
            return
        }
        
        gradientLayer.removeFromSuperlayer()
        layer.insertSublayer(gradientLayer, at: 0)

        if gradientColors.count > 0 {
            gradientLayer.colors = gradientColors.map({ return $0.cgColor })
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }else {
            if let startColor = gradientStartColor?.cgColor, let endColor = gradientEndColor?.cgColor {
                gradientLayer.colors = [startColor, endColor]
                gradientLayer.startPoint = startPoint
                gradientLayer.endPoint = endPoint
            }
        }
        
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.frame = bounds
    }
    
    /// 设置圆角、描边、阴影
    private func setCornerRadiusAndBorder() {
        
        if cornerRadius > 0 {
            layer.cornerRadius = cornerRadius
        }
        
        if borderWidth > 0 {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }

        if shadowRadius > 0 && shadowOpacity > 0 {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        
    }

}
