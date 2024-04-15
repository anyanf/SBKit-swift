//
//  SBPresentationController.swift
//  SBKit-swift
//
//  Created by ankang on 2023/12/8.
//

import Foundation

public class SBPresentationController: UIPresentationController, UIGestureRecognizerDelegate {
    
    public var sb_presentedViewFrame: CGRect?
    public var sb_containerViewBackgroundColor: UIColor?
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        
        guard let sb_presentedViewFrame = sb_presentedViewFrame else {
            return containerView?.bounds ?? CGRectZero
        }
        
        return sb_presentedViewFrame;
    }
    
    public override func containerViewWillLayoutSubviews() {
        
        if let sb_containerViewBackgroundColor = sb_containerViewBackgroundColor {
            presentedView?.superview?.backgroundColor = sb_containerViewBackgroundColor
        } else {
            presentedView?.superview?.backgroundColor = .gray.withAlphaComponent(0.3)
        }
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        
        var hasAddTap = false
        
        if let gestureRecognizers = containerView?.gestureRecognizers {
            for gesture in gestureRecognizers {
                if gesture is UITapGestureRecognizer {
                    hasAddTap = true
                    break
                }
            }
        }
        if !hasAddTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewDidTap(_:)))
            tapGesture.delegate = self // 设置代理
            containerView?.addGestureRecognizer(tapGesture)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let presentedView = presentedView else { return true }
        
        let location = touch.location(in: presentedView)
        
        // 如果点击位置不在子视图上，则执行手势
        return !presentedView.point(inside: location, with: nil)
    }

    
    @objc func containerViewDidTap(_ recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true) {
            
        }
    }
    
    
    
}
