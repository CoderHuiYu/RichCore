//
//  UIView+Observer.swift
//  MMNotes
//
//  Created by Liulu IT on 2022/6/17.
//

import UIKit

enum ViewAction {
    case add, remove
}

typealias ObserveHandler = (UIView, ViewAction) -> Void

var keyUIViewObservingHandler: UInt8 = 0xe

extension UIView{
    @objc func observingRemoveFromSuperview(){
        let parent = self.findObserverParent()
        self.observingRemoveFromSuperview()

        self.notifyObservingParent(self, parent: parent, action: .remove)
    }

    @objc func onDidAddSubview(_ subview: UIView) {
        self.notifyObservingParent(subview, action: .add)
    }

    private func notifyObservingParent(_ subview: UIView, parent: UIView? = nil, action: ViewAction){
        if let observingParent = parent ?? self.findObserverParent(){
            observingParent.getObservingHandler()?(subview, action)
        }
    }

    private func findObserverParent() -> UIView?{
        return self.superview?.findObserverParentPvt()
    }

    private func findObserverParentPvt() -> UIView?{
        if self.isObservingHierarchy(){
            return self
        }else{
            return self.superview?.findObserverParentPvt()
        }
    }

    private func isObservingHierarchy() -> Bool{
        return objc_getAssociatedObject(self, &keyUIViewObservingHandler) != nil
    }

    func observeHiearachy(handler: @escaping ObserveHandler){
        objc_setAssociatedObject(self, &keyUIViewObservingHandler, handler, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

    private func getObservingHandler() -> ObserveHandler?{
        return objc_getAssociatedObject(self, &keyUIViewObservingHandler) as? ObserveHandler
    }

}
