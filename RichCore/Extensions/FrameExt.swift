//
//  FrameExt.swift
//  Running
//
//  Created by yb on 2021/6/14.
//

import UIKit

public extension UIView {
    var left: CGFloat {
        get {
            frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            frame.maxX
        }
        set {
            frame.origin.x = max(0, newValue - width)
        }
    }
    
    var top: CGFloat {
        get {
            frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            frame.maxY
        }
        set {
            frame.origin.y = max(0, newValue - height)
        }
    }
    
    var width: CGFloat {
        get {
            frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            center.y
        }
        set {
            center.y = newValue
        }
    }
}
