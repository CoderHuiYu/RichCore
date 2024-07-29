// Copyright © 2022 MMCore. All rights reserved.

import UIKit

@objc public class TargetActionHandler : NSObject {
    private let action: () -> Void
    fileprivate var removeAction: (() -> Void)?

    fileprivate init(_ action: @escaping () -> Void) { self.action = action }

    @objc fileprivate func invoke() { action() }
    public func remove() { removeAction?() }
}

extension UIGestureRecognizer {
    @discardableResult
    @objc public func addHandler(_ handler: @escaping (UIGestureRecognizer) -> Void) -> TargetActionHandler {
        let wrap: () -> Void = { [weak self] in
            guard let self = self else {
                return
            }
            handler(self)
        }
        let target = TargetActionHandler(wrap)
        target.removeAction = { [weak self, unowned target] in self?.removeTarget(target, action: nil) }
        addTarget(target, action: #selector(TargetActionHandler.invoke))
        setAssociatedValue(target, forKey: unsafeBitCast(target, to: UnsafeRawPointer.self)) // Retain for lifetime of receiver
        return target
    }

    public convenience init(handler: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        addHandler(handler)
    }
    
    public convenience init(handler: @escaping () -> Void) {
        self.init()
        addHandler({ _ in
            handler()
        })
    }
}

extension UIControl {
    @discardableResult
    @objc public func addHandler(for events: UIControl.Event, handler: @escaping () -> Void) -> TargetActionHandler {
        let target = TargetActionHandler(handler)
        target.removeAction = { [weak self, unowned target] in self?.removeTarget(target, action: nil, for: .allEvents) }
        addTarget(target, action: #selector(TargetActionHandler.invoke), for: events)
        setAssociatedValue(target, forKey: unsafeBitCast(target, to: UnsafeRawPointer.self)) // Retain for lifetime of receiver
        return target
    }
}

extension UIButton {
    @discardableResult
    @objc public func addTapHandler(_ handler: @escaping () -> Void) -> TargetActionHandler {
        return addHandler(for: .touchUpInside, handler: handler)
    }
}

extension UIBarButtonItem {
    @objc public convenience init(title: String, font: UIFont? = nil, style: UIBarButtonItem.Style = .plain, handler: @escaping () -> Void) {
        let target = TargetActionHandler(handler)
        self.init(title: title, style: style, target: target, action: #selector(TargetActionHandler.invoke))
        setAssociatedValue(target, forKey: unsafeBitCast(target, to: UnsafeRawPointer.self)) // Retain for lifetime of receiver
        if let font = font {
            setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
    }
    
    convenience init(image: UIImage?, tintColor: UIColor? = nil, action: ActionClosure? = nil) {
        if let action = action {
            let target = TargetActionHandler(action)
            self.init(image: image, style: .plain, target: target, action: #selector(TargetActionHandler.invoke))
            setAssociatedValue(target, forKey: unsafeBitCast(target, to: UnsafeRawPointer.self)) // Retain for lifetime of receiver
        } else {
            self.init(image: image, style: .plain, target: nil, action: nil)
        }
        //self.tintColor = tintColor
    }
}

extension UIView {
    @discardableResult public func addTapGestureHandler(_ handler: @escaping (UIGestureRecognizer) -> Void) -> UITapGestureRecognizer {
        if !isUserInteractionEnabled {
            isUserInteractionEnabled = true
        }
        let tap = UITapGestureRecognizer.init(handler: handler)
        self.addGestureRecognizer(tap)
        return tap
    }
    
    @discardableResult public func addTapGestureHandler(_ handler: @escaping () -> Void) -> UITapGestureRecognizer {
        if !isUserInteractionEnabled {
            isUserInteractionEnabled = true
        }
        let tap = UITapGestureRecognizer.init(handler: { _ in
            handler()
        })
        self.addGestureRecognizer(tap)
        return tap
    }
}
