//
//  UIControlExtensions.swift
//  SBKit-swift
//
//  Created by ankang on 2023/7/17.
//

import Foundation

public extension UIControl {
    
    struct AssociatedKeys {
        static var eventBlockNameKey: String = "eventBlockNameKey"
        static var hitEdgeInsetsNameKey: String = "hitEdgeInsetsNameKey"
    }
    
    typealias SBControlEventBlock = (_ eventControl: UIControl, _ controlEvent: UIControl.Event) -> Void
    
    var hitEdgeInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitEdgeInsetsNameKey) as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hitEdgeInsetsNameKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    
    private var eventBlock: SBControlEventBlock? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.eventBlockNameKey) as? SBControlEventBlock
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventBlockNameKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTouchUpInsideEvent(eventBlock: @escaping SBControlEventBlock) {
        
        self.eventBlock = eventBlock
        
        let actions = actions(forTarget: self, forControlEvent: UIControl.Event.touchUpInside)
        
        // 如果添加过就不添加了
        if let actions = actions {
            
            for action in actions {
                if action == NSStringFromSelector(#selector(touchUpInsideEvent)) {
                    return
                }
            }
        }
        
        addTarget(self, action: #selector(touchUpInsideEvent), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func touchUpInsideEvent() {
        if let eventBlock = eventBlock {
            eventBlock(self, UIControl.Event.touchUpInside)
        }
    }
    
    
    // 调整响应范围重写的方法
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if let hitEdgeInsets = hitEdgeInsets {
            //如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
            if hitEdgeInsets == .zero || !self.isEnabled || self.isHidden || self.alpha == 0 {
                return super.point(inside: point, with: event)
            } else {
                let relativeFrame = self.bounds
                let hitFrame = relativeFrame.inset(by: UIEdgeInsets(top: -hitEdgeInsets.top,
                                                                    left: -hitEdgeInsets.left,
                                                                    bottom: -hitEdgeInsets.bottom,
                                                                    right: -hitEdgeInsets.right))
                return CGRectContainsPoint(hitFrame, point)
            }
        } else {
            return super.point(inside: point, with: event)
        }
    }
    
    
    
}
