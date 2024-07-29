//
//  UIView+Shadow.swift
//  PersonalManagement
//
//  Created by zhihu on 2023/10/21.
//

import UIKit

extension UIView {
    enum ShadowType: Int {
        case all = 0 ///四周
        case top  = 1 ///上方
        case left = 2///左边
        case right = 3///右边
        case bottom = 4///下方
    }
    ///默认设置：黑色阴影, 阴影所占视图的比例
    // func shadow(_ type: ShadowType, percent: Float) {
    // shadow(type: type, color: .black, opactiy: 0.4, //shadowSize: 4)
    //}
    ///默认设置：黑色阴影
    func shadow(_ type: ShadowType) {
        shadow(type: type, color: .black, opactiy: 0.4, shadowSize: 4)
    }
    
    public func ddaddShadow(opacity: Float = 0.25, radius: CGFloat, yOffset: CGFloat, color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: yOffset)
        layer.shadowColor = color.cgColor
    }
    
    ///常规设置
    func shadow(type: ShadowType, color: UIColor,  opactiy: Float, shadowSize: CGFloat, yOffset: CGFloat=2, radius: CGFloat=33) -> Void {
        layer.masksToBounds = false//必须要等于NO否则会把阴影切割隐藏掉
        layer.shadowColor = color.cgColor// 阴影颜色
        layer.shadowOpacity = opactiy// 阴影透明度，默认0
        layer.shadowOffset = CGSize(width: 0, height: yOffset)//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowRadius = 3 //阴影半径，默认3
        var shadowRect: CGRect?
        switch type {
        case .all:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        case .top:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
        case .bottom:
            shadowRect = CGRect.init(x: -shadowSize, y: bounds.size.height - shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
        case .left:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        case .right:
            shadowRect = CGRect.init(x: bounds.size.width - shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        }
        layer.shadowPath = UIBezierPath.init(rect: shadowRect!).cgPath
    }
    
}
