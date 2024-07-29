////
////  MBProgressHUDExt.swift
////  SFNotes
////
////  Created by yb on 2022/3/4.
////
//
//import MBProgressHUD
//
//
//extension MBProgressHUD {
//
//    static func tip(text: String, afterDelay: TimeInterval = 2.0) {
//        guard let target = UIWindow.keyWindow else {
//            return
//        }
//        let hud = MBProgressHUD(view: target)
//        hud.isUserInteractionEnabled = false
//        hud.removeFromSuperViewOnHide = true
//        hud.label.text = text
//        hud.mode = .text
//        hud.label.numberOfLines = 0
//        target.addSubview(hud)
//        hud.show(animated: true)
//        hud.hide(animated: true, afterDelay: afterDelay)
//    }
//    
//
//    static func tipLoading(superView: UIView? = nil, text: String? = nil) -> MBProgressHUD? {
//        let target = superView ?? UIApplication.shared.keyWindow
//        guard let target = target else {
//            return nil
//        }
//        let hud = MBProgressHUD.showAdded(to: target, animated: true)
//        hud.label.text = text
//        return hud
//    }
//    
//    //**** maximWidth 最大宽度
//    //**** offset 偏移设置
//    static func tip(text: String, duration: TimeInterval, offset: CGPoint = .zero, maximWidth: CGFloat? = nil) {
//        guard let target = UIWindow.keyWindow else {
//            return
//        }
//        let hud = MBProgressHUD(view: target)
//        hud.isUserInteractionEnabled = false
//        hud.removeFromSuperViewOnHide = true
//        hud.label.text = text
//        hud.label.font = .systemFont(ofSize: 13, weight: .medium)
//        hud.label.textColor = .nonStandardColor(withRGBHex: 0x000000)
//        hud.label.numberOfLines = 0
//        hud.offset = offset
//        if let maximWidth {
//            //fix
//            hud.label.preferredMaxLayoutWidth = maximWidth - 4 * hud.margin
//        }
//        hud.mode = .text
//        hud.bezelView.color = .clear
//        //hud.backgroundView.color = .white
//        //hud.backgroundColor = .white
//        target.addSubview(hud)
//        print(">>>> hud: \(hud.bezelView.bounds)")
//
//        hud.show(animated: true)
//        hud.hide(animated: true, afterDelay: duration)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
//            UIView.performWithoutAnimation {
//                let bounds = hud.bezelView.bounds
//                if bounds.width > bounds.height {
//                    hud.bezelView.cornerRadius = bounds.height/2.0;
//                } else {
//                    hud.bezelView.cornerRadius = 8.5
//                }
//                
//            }
//        }
//    }
//
//    
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//        
//    }
//    
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let hitView = super.hitTest(point, with: event)
//        //点击 bezelView 之外的地方 消除弹窗
//        let newpoint = self.convert(point, to: bezelView)
//        if !bezelView.point(inside: newpoint, with: nil) && !isHidden {
//            hide(animated: true)
//        }
//        return hitView
//        
//    }
//    
//    
//    
//    
//}
