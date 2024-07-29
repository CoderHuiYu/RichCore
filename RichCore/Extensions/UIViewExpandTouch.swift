//
//  UIViewExt.swift
//  Running
//
//  Created by yb on 2021/6/14.
//

import UIKit

private var expandTouchEdgeKey = 0

extension UIView {
    
    private static let hookHitTest: Void = {
        guard let orig = class_getInstanceMethod(UIView.self, #selector(point(inside:with:))),
              let rep = class_getInstanceMethod(UIView.self, #selector(expand_point(inside:with:))) else {
            return
        }
        method_exchangeImplementations(orig, rep)
    }()
    
} 

@IBDesignable
@objc public extension UIView {
    
    fileprivate func  expand_point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var newRect = bounds
        let expand = self.expandTouchEdge
        newRect.origin.x -= expand.left
        newRect.origin.y -= expand.top
        newRect.size.width += (expand.left + expand.right)
        newRect.size.height += (expand.top + expand.bottom)
        if newRect != bounds, newRect.contains(point) {
            return true
        }
        return expand_point(inside: point, with: event)
    }

    
    @IBInspectable var expandTouchLeft: CGFloat {
        get {
            expandTouchEdge.left
        }
        set {
            expandTouchEdge.left = newValue
        }
    }
    
    @IBInspectable var expandTouchRight: CGFloat {
        get {
            expandTouchEdge.right
        }
        set {
            expandTouchEdge.right = newValue
        }
    }
    
    @IBInspectable var expandTouchTop: CGFloat {
        get {
            expandTouchEdge.top
        }
        set {
            expandTouchEdge.top = newValue
        }
    }
    
    @IBInspectable var expandTouchBottom: CGFloat {
        get {
            expandTouchEdge.bottom
        }
        set {
            expandTouchEdge.bottom = newValue
        }
    }

    
    @IBInspectable var expandTouchEdge: UIEdgeInsets {
        get {
            objc_getAssociatedObject(self, &expandTouchEdgeKey) as? UIEdgeInsets ?? .zero
        }
        set {
            _ = UIView.hookHitTest
            objc_setAssociatedObject(self, &expandTouchEdgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
}
