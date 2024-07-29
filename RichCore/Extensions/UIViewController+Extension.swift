// Copyright © 2022 MMCore. All rights reserved.

import UIKit

extension UIViewController {
    static func current() -> UIViewController {
        guard let vc = UIWindow.keyWindow?.rootViewController else { return UIViewController() }
        return findBestViewController(viewController: vc)
    }
    
    static var root: UIViewController {
        guard let vc = UIWindow.keyWindow?.rootViewController else { return UIViewController() }
        return vc
    }
    
    static var currentWithoutPresented: UIViewController {
        guard let vc = UIWindow.keyWindow?.rootViewController else { return UIViewController() }
        return findBestViewController(viewController: vc, exceptPresented: true)
    }
    
    static func findBestViewController(viewController vc: UIViewController, exceptPresented: Bool = false) -> UIViewController {
      
        if (vc.presentedViewController != nil && exceptPresented == false) {
            return findBestViewController(viewController: vc.presentedViewController!)
        } else if (vc.isKind(of: UISplitViewController.self)) {
            guard let svc = vc as? UISplitViewController else { return vc }
            if svc.viewControllers.count > 0 {
                return findBestViewController(viewController: svc.viewControllers.last!, exceptPresented: exceptPresented)
            }
            return vc
        } else if (vc.isKind(of: UINavigationController.self)) {
            guard let nvc = vc as? UINavigationController else { return vc }
            if nvc.viewControllers.count > 0 {
                return findBestViewController(viewController: nvc.viewControllers.last!, exceptPresented: exceptPresented)
            }
            return vc
        } else if (vc.isKind(of: UITabBarController.self)) {
            guard let tvc = vc as? UITabBarController else { return vc }
            if tvc.viewControllers?.count ?? 0 > 0 {
                return findBestViewController(viewController: tvc.viewControllers!.last!, exceptPresented: exceptPresented)
            }
            return vc
        }else if let split = vc.children.first as? UISplitViewController {
            return findBestViewController(viewController: split)
        } else {
            return vc
        }
    }
        
}


private var pickerDismissAssociateKey: UInt8 = 0

extension UINavigationController {
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, _ complete: (() -> Void)?) {
        CATransaction.setCompletionBlock(complete)
        CATransaction.begin()
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
