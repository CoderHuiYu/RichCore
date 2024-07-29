// Copyright © 2022 MMCore. All rights reserved.

import UIKit 
public extension UIBarButtonItem {
    // MARK: Initializers
    
    static func editButtonItem(title: String = "编辑".local, action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .system, title: title, block: action)
//        button.tintColor = .MMEditColor
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: button)
    }
    
    static func noteButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .system, title: "笔记".local, block: action)
//        button.setTitleColor(.MMBarItemColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }


    static func backButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .light)), block: action)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }
    
    static func editItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "chevron.down.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .light)), block: action)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
      
    }

    static func addButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .light)), block: action)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }
    
    static func monthButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, block: action)
        button.setTitle("月", for: .normal)
        button.setTitleColor(.nonStandardColor(withRGBHex: 0x1F1F1F), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }
    
    static func weekButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, block: action)
        button.setTitle("周", for: .normal)
        button.setTitleColor(.nonStandardColor(withRGBHex: 0x588AFF), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }
    
    static func editButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage(named: "editImage"), block: action)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
    }
    
    static func modeButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage(named:"mode_horizon"), block: action)
        button.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
    }
    
    static func addButtonTitleItem(title: String, action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, title: title, titleColor: .nonStandardColor(withRGBHex: 0x588AFF), block: action)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)))
    }
    
    static func associateButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "link.badge.plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .light)), block: action)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10)))
    }
    
    static func sidebarButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "sidebar.squares.leading", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .light)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    static func bookmarkButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    static func pencilButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "pencil.tip.crop.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
        button.imageView?.tintColor = .white
        
        let bottomImageView = UIImageView(image: UIImage.image(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28*UIDevice.universalScale, weight: .regular)))
//        bottomImageView.tintColor = .MMBarItemColor
        let view = UIView(wrapping: bottomImageView, with: UIEdgeInsets(horizontal: 6, vertical: 0))
        view.addSubview(button, pinningEdges: .all, withInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        return UIBarButtonItem(customView: view)
    }
    
    static func draftButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "note", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18*UIDevice.universalScale, weight: .regular)), block: action)
        button.imageView?.tintColor = .white
        
        let bottomImageView = UIImageView(image: UIImage.image(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28*UIDevice.universalScale, weight: .regular)))
        let view = UIView(wrapping: bottomImageView, with: UIEdgeInsets(horizontal: 6, vertical: 0))
        view.addSubview(button, pinningEdges: .all, withInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        return UIBarButtonItem(customView: view)
    }
    
    static func micButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "mic", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    
    static func mindButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "increase.indent", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    
    static func webButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "safari", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    static func magnifyingglassButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 8)))
    }
    
    static func ellipsisButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "ellipsis.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }

    //play.rectangle
    static func videoButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "play.rectangle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    static func fullScreenButtonItem(action: @escaping ActionClosure) -> UIBarButtonItem {
        let button = UIButton(type: .custom, icon: UIImage.image(systemName: "arrow.up.left.and.arrow.down.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22*UIDevice.universalScale, weight: .regular)), block: action)
//        button.imageView?.tintColor = .MMBarItemColor
        return UIBarButtonItem(customView: UIView(wrapping: button, with: UIEdgeInsets(horizontal: 8, vertical: 0)))
    }
    
    // MARK: Convenience
    private static func button(with image: UIImage?, tintColor: UIColor?, actionBlock: ActionClosure?, target: AnyObject?, actionSelector: Selector?) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32.0, height: 32.0)) // This is the necessary button frame to make the icon fit in the nav bar with the desired spacing between them, according to the design.
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.tintColor = tintColor
        if let actionBlock = actionBlock {
            button.addTapHandler(actionBlock)
        }
        if let selector = actionSelector, target?.responds(to: selector) ?? false {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        return button
    }
    
}
