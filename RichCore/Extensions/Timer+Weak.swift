//
//  Timer+Weak.swift
//  MMNotes
//
//  Created by Liulu IT on 2022/6/24.
//

import Foundation

public class MMWeakTimerProxy: NSObject {
    weak var target: NSObjectProtocol?
    var sel: Selector?
    public weak var timer: Timer?
    
    public required init(target: NSObjectProtocol?, sel: Selector?) {
        self.target = target
        self.sel = sel
        
        super.init()
        guard target?.responds(to: sel) == true else { return }
        let method = class_getInstanceMethod(self.classForCoder, #selector(redirectionMethod))!
        class_replaceMethod(self.classForCoder, sel!, method_getImplementation(method), method_getTypeEncoding(method))
    }
    
    @objc func redirectionMethod() {
        if self.target != nil {
            self.target?.perform(self.sel)
        } else {
            self.timer?.invalidate()
        }
    }
}

public extension Timer {
    class func MM_scheduledTimer(timerInterval ti: TimeInterval, target aTarget: NSObjectProtocol, selector aSelector: Selector, userInfo aInfo: Any?, repeats yesOrNo: Bool) -> Timer {
        let proxy = MMWeakTimerProxy.init(target: aTarget, sel: aSelector)
        let timer = Timer.scheduledTimer(timeInterval: ti, target: proxy, selector: aSelector, userInfo: aInfo, repeats: yesOrNo)
        proxy.timer = timer
        return timer
    }
    
    
    
    
    
}
