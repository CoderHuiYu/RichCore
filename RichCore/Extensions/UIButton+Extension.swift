// Copyright © 2022 MMCore. All rights reserved.
import UIKit

/// A convenient holder for an action closure together with the title and/or icon it should have when set on a button.
public class MMButtonAction : NSObject { // Should be a struct in pure swift
    @objc public var title: String?
    public var color: UIColor?
    @objc public var icon: UIImage?
    @objc public var block: ActionClosure?

    @objc public init(title: String? = nil, color: UIColor? = nil, icon: UIImage? = nil, block: ActionClosure? = nil) {
        (self.title, self.color, self.icon, self.block) = (title, color, icon, block)
        super.init()
    }
}

extension UIButton {
    public var title: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    public func set(_ title: String?, state: UIControl.State = .normal, animated: Bool = false) {
        guard animated else { return setTitle(title, for: .normal) }
        UIView.performWithoutAnimation {
            setTitle(title, for: .normal)
            layoutIfNeeded()
        }
    }
    
    public func set(systemImage imageName: String, state: UIControl.State = .normal, animated: Bool = false) {
        let image = UIImage(systemName: imageName)
        guard animated else { return  setImage(image, for: .normal) }
        UIView.performWithoutAnimation {
            setImage(image, for: .normal)
            layoutIfNeeded()
        }
    }
    
}



@IBDesignable
public extension UIButton {
    @IBInspectable var normalStatusBackgroundColor : UIColor? {
        set {
            if let color = newValue {
                let img = UIImage.imageWithColor(color)
                self.setBackgroundImage(img, for: .normal)
            } else {
                self.setBackgroundImage(nil, for: .normal)
            }
        }
        get {
            return nil
        }
    }
    @IBInspectable var pressedStatusBackgroundColor : UIColor? {
        set {
            if let color = newValue {
                let img = UIImage.imageWithColor(color)
                self.setBackgroundImage(img, for: .highlighted)
            } else {
                self.setBackgroundImage(nil, for: .highlighted)
            }
        }
        get {
            return nil
        }
    }
    @IBInspectable var disabledStatusBackgroundColor : UIColor? {
        set {
            if let color = newValue {
                let img = UIImage.imageWithColor(color)
                self.setBackgroundImage(img, for: .disabled)
            } else {
                self.setBackgroundImage(nil, for: .disabled)
            }
        }
        get {
            return nil
        }
    }
    
    @IBInspectable var selectedStatusBackgroundColor : UIColor? {
        set {
            if let color = newValue {
                let img = UIImage.imageWithColor(color)
                self.setBackgroundImage(img, for: .selected)
            } else {
                self.setBackgroundImage(nil, for: .selected)
            }
        }
        get {
            return nil
        }
    }
}
