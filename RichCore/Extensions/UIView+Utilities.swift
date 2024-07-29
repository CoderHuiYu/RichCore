// Copyright © 2022 MMCore. All rights reserved.

import Foundation
import UIKit

public func += <Element>(lhs: inout [Element], rhs: Element) { lhs.append(rhs) }

extension UIView {
    
    var controller: UIViewController? {
        var ctl: UIResponder? = self.next
        while ctl != nil && !(ctl is UIViewController) {
            ctl = ctl?.next
        }
        return ctl as? UIViewController
    }
    
    // MARK: Constraints
    /// - Note: this used to be an utility to help manage the bottom anchor for OS versions prior to iOS 11, but now it's equivalent to `safeAreaLayoutGuide.bottomAnchor`.
    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    /// - Note: this used to be an utility to help manage the top anchor for OS versions prior to iOS 11, but now it's equivalent to `safeAreaLayoutGuide.topAnchor`.
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    public convenience init(wrapping view: UIView, with insets: UIEdgeInsets = .zero) {
        self.init()
        addSubview(view, pinningEdges: .all, withInsets: insets)
    }
    
    public func addSubview(_ subview: UIView, pinningEdgesToSafeArea edges: UIRectEdge, withInsets insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.pinEdges(edges: edges, to: self, withInsets: insets, useSafeArea: true)
    }

    @objc public func addSubview(_ subview: UIView, pinningEdges edges: UIRectEdge, withInsets insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.pinEdges(edges: edges, to: self, withInsets: insets, useSafeArea: false)
    }

    @discardableResult public func pinEdges(edges: UIRectEdge = .all, to view: UIView, withInsets insets: UIEdgeInsets = .zero, useSafeArea: Bool = true, collapseInsets: Bool = false) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.left) {
            constraints += leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        }
        if edges.contains(.right) {
            constraints += view.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right)
        }
        if edges.contains(.top) {
            if useSafeArea && collapseInsets {
                constraints += topAnchor.constraint(greaterThanOrEqualTo: view.safeTopAnchor)
                constraints += topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).with(priority: .pseudoRequired)
            } else {
                let viewTopAnchor = useSafeArea ? view.safeTopAnchor : view.topAnchor
                constraints += topAnchor.constraint(equalTo: viewTopAnchor, constant: insets.top)
            }
        }
        if edges.contains(.bottom) {
            if useSafeArea && collapseInsets {
                constraints += view.safeBottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor)
                constraints += view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).with(priority: .pseudoRequired)
            } else {
                let viewBottomAnchor = useSafeArea ? view.safeBottomAnchor : view.bottomAnchor
                constraints += viewBottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
            }
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    // MARK: Decoration
    /// Adds separators to the given edges.
    /// - Parameters:
    ///   - edges: The edges where the separators will be added to.
    ///   - thickness: The thickness of the separator. Defaults to 1px (not 1pt).
    /// - Returns: an array containing only the separators that were requested to be added. The order of the views are: left, right, top and bottom.
    @discardableResult public func addSeparator(onEdges edges: UIRectEdge, thickness: CGFloat = 1 / UIScreen.main.scale, color: UIColor = .nonStandardColor(withRGBHex: 0xC0BFC3), withInsets insets: UIEdgeInsets = .zero) -> [UIView] {
        var result: [UIView] = []
        if edges.contains(.left) { result += addSeparator(on: .minXEdge, thickness: thickness, color: color, withInsets: insets) }
        if edges.contains(.right) { result += addSeparator(on: .maxXEdge, thickness: thickness, color: color, withInsets: insets) }
        if edges.contains(.top) { result += addSeparator(on: .minYEdge, thickness: thickness, color: color, withInsets: insets) }
        if edges.contains(.bottom) { result += addSeparator(on: .maxYEdge, thickness: thickness, color: color, withInsets: insets) }
        return result
    }

    /// Removes separators added by the method `addSeparator(onEdges:thickness:)`.
    public func removeSeparators() {
        subviews.forEach { ($0 as? Separator)?.removeFromSuperview() }
    }

    private func addSeparator(on edge: CGRectEdge, thickness: CGFloat, color: UIColor, withInsets insets: UIEdgeInsets = .zero) -> UIView {
        let separator = Separator()
        separator.backgroundColor = color
        switch edge {
        case .minXEdge, .maxXEdge:
            addSubview(separator, pinningEdgesToSafeArea: [ .top, .bottom, edge == .minXEdge ? .left : .right ], withInsets: insets)
            NSLayoutConstraint.activate([ separator.widthAnchor.constraint(equalToConstant: thickness) ])
        case .minYEdge, .maxYEdge:
            addSubview(separator, pinningEdgesToSafeArea: [ .left, .right, edge == .minYEdge ? .top : .bottom ], withInsets: insets)
            NSLayoutConstraint.activate([ separator.heightAnchor.constraint(equalToConstant: thickness) ])
        }
        return separator
    }

    private class Separator : UIView {}
}

extension NSLayoutConstraint {
    @discardableResult public func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UILayoutPriority {
    public static var pseudoRequired: UILayoutPriority { return UILayoutPriority(rawValue: 999) }
    public static var lowCompressionResistance: UILayoutPriority { return UILayoutPriority(rawValue: 740) }
    public static var defaultCompressionResistance: UILayoutPriority { return UILayoutPriority(rawValue: 750) }
    public static var highCompressionResistance: UILayoutPriority { return UILayoutPriority(rawValue: 760) }
    public static var medium: UILayoutPriority { return UILayoutPriority(rawValue: 500) }
    public static var lowHuggingPriority: UILayoutPriority { return UILayoutPriority(rawValue: 240) }
    public static var defaultHuggingPriority: UILayoutPriority { return UILayoutPriority(rawValue: 250) }
    public static var highHuggingPriority: UILayoutPriority { return UILayoutPriority(rawValue: 260) }
}

private var _keyWindow: UIWindow?
extension UIWindow {
    static var keyWindow: UIWindow? {
        get {
            return _keyWindow
        }
        set {
            _keyWindow = newValue
        }
    }
    
    static var rootView: UIView? {
        get {
            UIWindow.keyWindow?.rootViewController?.view
        }
    }
}


extension UIView {

    public func addShadow(opacity: Float = 0.25, radius: CGFloat, yOffset: CGFloat, color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: yOffset)
        layer.shadowColor = color.cgColor
    }

    public func removeShadow() {
        layer.shadowOpacity = 0
    }

    public func addShadowAndRoundCorner(opacity: Float = 0.25, radius: CGFloat, yOffset: CGFloat, color: UIColor = .black, cornerRadius: CGFloat) {
        layer.shadowOffset = CGSize(width: 0, height: yOffset)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
    }

    public func generateOuterShadow() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = layer.cornerRadius
        view.layer.shadowRadius = layer.shadowRadius
        view.layer.shadowOpacity = layer.shadowOpacity
        view.layer.shadowColor = layer.shadowColor
        view.layer.shadowOffset = layer.shadowOffset
        view.clipsToBounds = false
        view.backgroundColor = .white

        superview?.insertSubview(view, belowSubview: self)

        let constraints = [
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
        ]
        superview?.addConstraints(constraints)
    }
    
}

extension UIView {
    
    var viewController: UIViewController? {
        var next: UIResponder? = self.next
        while next != nil && !(next is UIViewController) {
            next = next?.next
        }
        return next as? UIViewController
    }
    
    private func getParentType<T>(type: T.Type) -> T? {
        var next: UIResponder? = self.next
        while next != nil && !(next is T) {
            next = next?.next
        }
        return next as? T
    }
    
    func getParentViewController<T: UIViewController>(type: T.Type) -> T? {
        return getParentType(type: T.self)
    }
    
    func getParentView<T: UIView>(type: T.Type) -> T? {
        return getParentType(type: T.self)
    }
    
    
    
    /// Helper Method
    
    static func spaceVertical(_ space: CGFloat=0, isMultiplyScale: Bool = true) -> UIView {
        return UIView.spaceView(space, isVertical: true, isMultiplyScale: isMultiplyScale)
    }
    
    static func spaceHorizontal(_ space: CGFloat=0, isMultiplyScale: Bool = true) -> UIView {
        return UIView.spaceView(space, isVertical: false, isMultiplyScale: isMultiplyScale)
    }
    
    static func spaceView(_ space: CGFloat=0, isVertical: Bool = false, isMultiplyScale: Bool = true) -> UIView {
        let result = UIView()
        
        if isVertical {
            if space != 0 {
                if isMultiplyScale {
                    result.constrainHeight(to: space*UIDevice.universalScale)
                    return result
                }
                result.constrainHeight(to: space)
            }
        } else {
            if space != 0 {
                if isMultiplyScale {
                    result.constrainWidth(to: space*UIDevice.universalScale)
                    return result
                }
                result.constrainWidth(to: space)
            }
        }
        return result
    }
    
    func snapshotToImage(_ scale: CGFloat = 0.0 ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: ctx)
//        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    // 渐变色背景设置
    func setLayerColors(_ colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]?=nil) {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.locations = locations
        self.layer.addSublayer(layer)
    }
    
    
    func scaleView(scale: CGFloat) {
        self.contentScaleFactor = scale
        self.subviews.forEach { v in
            v.scaleView(scale: scale)
        }
    }
    
    func scaleLayer(scale: CGFloat) {
        layer.contentsScale = scale
        layer.magnificationFilter = .nearest
        self.subviews.forEach { v in
            v.scaleLayer(scale: scale)
        }
    }
}


extension UIView {
    func removeGestureRecognizer<T: UIGestureRecognizer>(type: T.Type) {
        gestureRecognizers?.forEach { gr in
            guard let gr = gr as? T else {
                return
            }
            removeGestureRecognizer(gr)
        }
    }
    
    func getGestureRecognizers<T: UIGestureRecognizer>(type: T.Type) -> [T] {
        return gestureRecognizers?.compactMap({$0 as? T}) ?? []
    }
}



extension UIView {
    /// Sets the corner radius to this view.
    /// - Note: if you call this method multiple times, only the last call will prevail, discarding the changes made by any previous call.
    public func setCornerRadius(_ cornerRadius: CornerRadius) {
        setCorner(cornerRadius.corners, radius: cornerRadius.radius)
    }

    /// Sets the corner radius to the given corners.
    /// - Parameters:
    ///   - corners: The corners to apply the radius for. Defaults to all corners.
    ///   - radius: The radius to apply on the given corners.
    /// - Note: if you call this method multiple times, only the last call will prevail, discarding the changes made by any previous call.
    public func setCorner(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        setCorner(corners, radius: radius, boundsForCorner: bounds)
    }

    /// Sets the corner radius to the given corners.
    /// - Parameters:
    ///   - corners: The corners to apply the radius for. Defaults to all corners.
    ///   - radius: The radius to apply on the given corners.
    ///   - boundsForCorner: The shape layer's frame.
    /// - Note: if you call this method multiple times, only the last call will prevail, discarding the changes made by any previous call.
    public func setCorner(_ corners: UIRectCorner = .allCorners, radius: CGFloat, boundsForCorner: CGRect) {
        let maskPath = UIBezierPath(roundedRect: boundsForCorner, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = boundsForCorner
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

}
